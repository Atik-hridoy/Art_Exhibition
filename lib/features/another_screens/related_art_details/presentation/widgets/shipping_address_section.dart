
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:get/get.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/constants/app_string.dart';
import '../controller/check_out_controller.dart';

class ShippingAddressSection extends StatelessWidget {
  const ShippingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutController>(
      builder: (controller) => Column(
      children: [

        10.height,

        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.stroke)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                height: 48.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(8.r), topLeft: Radius.circular(8.r))
                ),
                child: Row(
                  children: [
                    Icon(
                        size: 26.sp,
                        color: AppColors.white,
                        Icons.home_outlined),

                    6.width,

                    CommonText(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        text: AppString.shippingAddress),
                    Spacer(),
                    InkWell(
                      onTap: () => _showEditDialog(context, controller),
                      child: CommonImage(
                          height: 24,
                          width: 24,
                          imageSrc: AppImages.editIcon),
                    )
                  ],
                ),
              ),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    12.height,
                    Row(
                      children: [
                        Icon(

                            size: 20.sp,
                            color: AppColors.bodyClr,
                            Icons.person_outline_sharp),
                        6.width,

                        CommonText(
                            
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.bodyClr,
                            text: controller.name)
                      ],
                    ),

                    15.height,
                    Row(
                      children: [
                        Icon(

                            size: 20.sp,
                            color: AppColors.bodyClr,
                            Icons.phone_callback),
                        6.width,

                        CommonText(
                            
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.bodyClr,
                            text: controller.phone)
                      ],
                    ),


                    15.height,
                    Row(
                      children: [
                        Icon(

                            size: 20.sp,
                            color: AppColors.bodyClr,
                            Icons.location_on_outlined),
                        6.width,

                        Expanded(
                          child: CommonText(
                              textAlign: TextAlign.start,
                              maxLines: 2,

                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.bodyClr,
                              text: controller.address),
                        )
                      ],
                    ),

                    12.height


                  ],
                ),
              ),




            ],
          ),
        ),

        // ShippingAddressSection now ends here; delivery and payment are handled in the screen
      ],
    ));
  }

  void _showEditDialog(BuildContext context, CheckOutController c) {
    Get.dialog(
      AnimatedPadding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        duration: const Duration(milliseconds: 200),
        curve: Curves.decelerate,
        child: Dialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                    text: AppString.editShippingInfo,
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(2.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.bodyClr),
                      ),
                      child: Icon(Icons.close, color: AppColors.bodyClr)),
                  )
                ],
              ),
              16.height,
              CommonText(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
                text: AppString.yourName,
              ),
              8.height,
              CommonTextField(
                hintText: AppString.enterYourName,
                borderColor: AppColors.stroke,
                controller: c.nameCtrl,
              ),
              16.height,
              CommonText(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
                text: AppString.phoneNumber,
              ),
              8.height,
              CommonTextField(
                hintText: AppString.enterYourPhoneNumber,
                borderColor: AppColors.stroke,
                keyboardType: TextInputType.phone,
                controller: c.phoneCtrl,
              ),
              16.height,
              CommonText(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
                text: AppString.shippingAddress,
              ),
              8.height,
              CommonTextField(
                hintText: AppString.enterYourShippingAddress,
                borderColor: AppColors.stroke,
                maxline: 2,
                controller: c.addressCtrl,
              ),
              20.height,
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                              titleSize: 14,
                      titleWeight: FontWeight.w600,
                      titleText: AppString.cancel,
                      titleColor: AppColors.primaryColor,
                      buttonColor: AppColors.transparent,
                      borderColor: AppColors.primaryColor,
                      onTap: () => Get.back(),
                      buttonRadius: 60,
                    ),
                  ),
                  12.width,
                  Expanded(
                    child: CommonButton(
                      titleSize: 14,
                      titleWeight: FontWeight.w600,
                      titleText: AppString.saveChanges,
                      onTap: () {
                        c.saveShippingEdits();
                        Get.back();
                      },
                      buttonRadius: 60,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    )));
  }




}
