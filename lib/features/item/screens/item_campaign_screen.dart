import 'package:dubucket/features/item/controllers/campaign_controller.dart';
import 'package:dubucket/util/dimensions.dart';
import 'package:dubucket/common/widgets/custom_app_bar.dart';
import 'package:dubucket/common/widgets/footer_view.dart';
import 'package:dubucket/common/widgets/item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dubucket/common/widgets/menu_drawer.dart';

class ItemCampaignScreen extends StatefulWidget {
  final bool isJustForYou;
  const ItemCampaignScreen({super.key, required this.isJustForYou});

  @override
  State<ItemCampaignScreen> createState() => _ItemCampaignScreenState();
}

class _ItemCampaignScreenState extends State<ItemCampaignScreen> {
  @override
  void initState() {
    super.initState();

    Get.find<CampaignController>().getItemCampaignList(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.isJustForYou ? 'just_for_you'.tr : 'campaigns'.tr),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: SingleChildScrollView(
        child: FooterView(
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: GetBuilder<CampaignController>(builder: (campController) {
              return ItemsView(
                isStore: false,
                items: campController.itemCampaignList,
                stores: null,
                isCampaign: true,
                noDataText: 'no_campaign_found'.tr,
              );
            }),
          ),
        ),
      ),
    );
  }
}
