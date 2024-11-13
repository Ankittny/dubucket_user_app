import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dubucket/features/language/controllers/language_controller.dart';
import 'package:dubucket/features/checkout/controllers/checkout_controller.dart';
import 'package:dubucket/helper/route_helper.dart';
import 'package:dubucket/util/dimensions.dart';
import 'package:dubucket/util/images.dart';
import 'package:dubucket/util/styles.dart';
import 'package:dubucket/common/widgets/custom_text_field.dart';

class GuestDeliveryAddress extends StatelessWidget {
  final CheckoutController checkoutController;
  final TextEditingController guestNameTextEditingController;
  final TextEditingController guestNumberTextEditingController;
  final TextEditingController guestEmailController;
  final FocusNode guestNumberNode;
  final FocusNode guestEmailNode;
  const GuestDeliveryAddress({super.key, required this.checkoutController, required this.guestNameTextEditingController,
    required this.guestNumberTextEditingController, required this.guestNumberNode, required this.guestEmailController, required this.guestEmailNode,
  });

  @override
  Widget build(BuildContext context) {
    bool takeAway = (checkoutController.orderType == 'take_away');

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.05), blurRadius: 10)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall),
      child: Column(children: [
        Row(children: [
          Image.asset(Images.truck, height: 14, width: 14, color: Theme.of(context).primaryColor),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Text(takeAway ? 'contact_information'.tr : 'delivery_information'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),
          const Spacer(),

          takeAway ? const SizedBox() : InkWell(
            onTap: () async {
              String? previousGuestAddress = checkoutController.guestAddress?.address;
              var address = await Get.toNamed(RouteHelper.getEditAddressRoute(checkoutController.guestAddress, fromGuest: true));

              if(address != null) {
                checkoutController.setGuestAddress(address);
                if(previousGuestAddress != address.deliveryAddress) {
                  checkoutController.getDistanceInKM(
                    LatLng(double.parse(address.latitude), double.parse(address.longitude)),
                    LatLng(double.parse(checkoutController.store!.latitude!), double.parse(checkoutController.store!.longitude!)),
                  );
                }
              }
            },
            child: Image.asset(Images.editDelivery, height: 20, width: 20, color: Theme.of(context).primaryColor),
          ),
        ]),

        Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
          child: Divider(color: Theme.of(context).disabledColor),
        ),

        takeAway ? Column(children: [
          const SizedBox(height: Dimensions.paddingSizeLarge),
          CustomTextField(
            labelText: 'contact_person_name'.tr,
            titleText: 'write_name'.tr,
            inputType: TextInputType.name,
            controller: guestNameTextEditingController,
            nextFocus: guestNumberNode,
            capitalization: TextCapitalization.words,
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),

          CustomTextField(
            labelText: 'contact_person_number'.tr,
            titleText: 'write_number'.tr,
            controller: guestNumberTextEditingController,
            focusNode: guestNumberNode,
            nextFocus: guestEmailNode,
            inputType: TextInputType.phone,
            isPhone: true,
            onCountryChanged: (CountryCode countryCode) {
              checkoutController.countryDialCode = countryCode.dialCode;
            },
            countryDialCode: checkoutController.countryDialCode ?? Get.find<LocalizationController>().locale.countryCode,
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),

          CustomTextField(
            titleText: 'enter_email'.tr,
            labelText: 'email'.tr,
            controller: guestEmailController,
            focusNode: guestEmailNode,
            inputAction: TextInputAction.done,
            inputType: TextInputType.emailAddress,
            prefixIcon: Icons.mail,
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),

        ]) : checkoutController.guestAddress == null ? InkWell(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
            child: Column(children: [
              Image.asset(Images.truck, height: 20, width: 20, color: Theme.of(context).disabledColor),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              Text('please_update_your_delivery_info'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).disabledColor)),
            ]),
          ),
        ) : Column(children: [
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),

          Row(children: [
            Icon(Icons.location_on, size: 16, color: Theme.of(context).primaryColor.withOpacity(0.5)),
            const SizedBox(width: Dimensions.paddingSizeSmall),

            Flexible(child: Text(
              checkoutController.guestAddress!.address!,
              style: robotoRegular, maxLines: 1, overflow: TextOverflow.ellipsis,
            )),
          ]),
          const SizedBox(height: Dimensions.paddingSizeSmall),

          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(flex: 6, child: Column(children: [
              addressInfo('address_type'.tr, checkoutController.guestAddress!.addressType!),
              addressInfo('name'.tr, checkoutController.guestAddress!.contactPersonName!),
              addressInfo('phone'.tr, checkoutController.guestAddress!.contactPersonNumber!),
              addressInfo('email'.tr, checkoutController.guestAddress!.email!),
            ])),
            Expanded(flex: 4, child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              addressInfo('street'.tr, checkoutController.guestAddress!.streetNumber!),
              addressInfo('house'.tr, checkoutController.guestAddress!.house!),
              addressInfo('floor'.tr, checkoutController.guestAddress!.floor!),
            ])),
          ])
        ]),

      ]),
    );
  }

  Widget addressInfo(String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(children: [
        Text('$key: ', style: robotoRegular.copyWith(color: Theme.of(Get.context!).disabledColor)),
        Flexible(child: Text(value, style: robotoRegular, maxLines: 1, overflow: TextOverflow.ellipsis)),
      ]),
    );
  }
}
