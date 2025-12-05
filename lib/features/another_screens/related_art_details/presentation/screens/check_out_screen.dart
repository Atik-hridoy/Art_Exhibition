
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/component/text_field/common_text_field.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import '../widgets/place_order_section.dart';
import '../widgets/shipping_address_section.dart';
import '../controller/check_out_controller.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments ?? {};
    final String artId = arguments['artId'] ?? '';
    final num artPrice = arguments['price'] ?? 0;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Get.back();
          },


            child: Icon(

        color: AppColors.titleColor,
        Icons.arrow_back_ios,size: 23.sp,)

        ),

        shadowColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        backgroundColor: AppColors.background,
        title: CommonText(

            fontSize: 16,
            fontWeight: FontWeight.w600,
            text: AppString.checkout),),

      body: GetBuilder<CheckOutController>(
        init: CheckOutController(),
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
        
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: ShippingAddressSection(),
            ),
            24.height,

            // Additional Noted
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.titleColor,
                      text: 'Additional Noted').start,
                  12.height,
                  CommonTextField(
                    hintText: 'Write Additional Notes for seller',
                    borderColor: AppColors.bodyClr,
                    maxline: 4,
                    controller: controller.noteCtrl,
                  ),
                ],
              ),
            ),

      

       

            // Order Summary and CTA
            PlaceOrderSection(
              artId: artId,
              artPrice: artPrice,
            )
          ],
        ),
      ),
    ));
  }
}
