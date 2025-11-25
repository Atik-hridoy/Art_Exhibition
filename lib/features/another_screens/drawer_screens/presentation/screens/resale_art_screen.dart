import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/component/text_field/common_text_field.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import '../controller/resale_art_controller.dart';
import '../widgets/resale_condition_field.dart';
import '../widgets/resale_info_card.dart';

class ResaleArtScreen extends StatelessWidget {
  const ResaleArtScreen({super.key, required this.order});

  final Map<String, dynamic> order;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResaleArtController>(
      init: ResaleArtController(order: order),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () => Get.back(),
            ),
            title: const CommonText(text: AppString.resaleArt, fontWeight: FontWeight.w600),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CommonImage(
                    height: 300.h,
                    width: double.infinity,
                    fill: BoxFit.cover,
                    imageSrc: AppImages.arts,
                  ),
                ),
                12.height,
                CommonText(
                  text: order['title'] ?? AppString.artworkTitle,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.titleColor,
                ),
               4.height,
                CommonText(
                  text: order['subTitle'] ?? AppString.abstractLabel,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.titleColor,
                ),
                14.height,
                ResaleInfoCard(originalPrice: (order['price'] ?? '2500').toString()),
                20.height,
                CommonText(
                  text: AppString.setYourPrice,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.titleColor,
                ),
                8.height,
                CommonTextField(
                  borderColor: AppColors.stroke,
                  controller: controller.priceCtrl,
                  keyboardType: TextInputType.number,
                  hintText: AppString.enterAmount,
                  prefixText: '\$',
                ),
                20.height,
                CommonText(
                  text: AppString.productCondition,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.titleColor,
                ),
                8.height,
                ResaleConditionField(controller: controller),
                20.height,
                CommonText(
                  text: AppString.additionalInfo,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.titleColor,
                ),
                8.height,
                CommonTextField(
                  controller: controller.infoCtrl,
                  maxline: 3,
                  borderColor: AppColors.stroke,
                  fillColor: Colors.white,
                  hintText: AppString.writeDownAdditionalInfo,
                ),
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonText(
                      text: AppString.acceptOffersFromBuyers,
                      fontSize: 14,
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.w500,
                      color: AppColors.titleColor,
                    ),
                    Obx(() => Switch(
                          value: controller.acceptOffers.value,
                          onChanged: controller.toggleAccept,
                          activeThumbColor: AppColors.primaryColor,
                        )),
                  ],
                ),
                16.height,
                CommonButton(
                  titleText: AppString.cancel,
                  onTap: () => Get.back(),
                  titleColor: AppColors.red,
                  buttonColor: Colors.transparent,
                  borderColor: AppColors.red,
                  buttonRadius: 30,
                  buttonHeight: 48,
                  borderWidth: 1,
                ),
                10.height,
                CommonButton(
                  titleText: AppString.addListing,
                  onTap: controller.submitListing,
                  titleColor: Colors.white,
                  buttonColor: AppColors.primaryColor,
                  borderColor: AppColors.primaryColor,
                  buttonRadius: 30,
                  buttonHeight: 48,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
