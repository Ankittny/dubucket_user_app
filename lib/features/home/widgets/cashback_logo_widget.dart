import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dubucket/common/widgets/custom_asset_image_widget.dart';
import 'package:dubucket/util/images.dart';
import 'package:dubucket/util/styles.dart';
class CashBackLogoWidget extends StatelessWidget {
  const CashBackLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomAssetImageWidget(Images.cashBack),

        Positioned(
          top: 10, left: 15,
          child: Text('cash_back'.tr, style: robotoBold.copyWith(color: Colors.white)),
        )
      ],
    );
  }
}
