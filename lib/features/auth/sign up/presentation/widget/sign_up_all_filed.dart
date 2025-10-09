import 'package:flutter/material.dart';
import '../../../../../utils/helpers/other_helper.dart';
import '../../../../../utils/constants/app_string.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/sign_up_controller.dart';
import '../../../../../utils/constants/app_colors.dart';
import 'choose_role_bottomsheet.dart';

class SignUpAllField extends StatelessWidget {
  const SignUpAllField({super.key, required this.controller});

  final SignUpController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// User Name here
        CommonText(
          fontSize: 14,
          color: AppColors.titleColor,
          fontWeight: FontWeight.w700,
          text: AppString.fullName,
          bottom: 8,
          top: 12,
        ),
        CommonTextField(
          borderColor: AppColors.normalGray2,

          hintText: AppString.enterYourFullName,
          controller: controller.nameController,
          validator: OtherHelper.validator,
        ),

        /// User Email here
        const CommonText(
          fontSize: 14,

          fontWeight: FontWeight.w700,
          text: AppString.email,
          bottom: 8,
          top: 12,
        ),
        CommonTextField(
          borderColor: AppColors.normalGray2,
          controller: controller.emailController,

          hintText: AppString.enterValidEmail,
          validator: OtherHelper.emailValidator,
        ),

        // /// User Name here
        // CommonText(
        //     fontSize: 14,
        //     color: AppColors.titleColor,
        //     fontWeight: FontWeight.w700,
        //     text: AppString.chooseRole, bottom: 8, top: 12),
        // CommonTextField(
        //   suffixIcon: InkWell(
        //     onTap: (){
        //       chooseRoleBottomSheet(context);
        //     },
        //     child: Icon(
        //         color: AppColors.bodyClr,
        //         Icons.keyboard_arrow_down_rounded),
        //   ),
        //   borderColor: AppColors.normalGray2,

        //   hintText: AppString.selectYourRole,
        //   controller: controller.chooseRoleController,
        //   validator: OtherHelper.validator,
        // ),

        /// User Password here
        const CommonText(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          text: AppString.password,
          bottom: 8,
          top: 12,
        ),
        CommonTextField(
          borderColor: AppColors.normalGray2,

          controller: controller.passwordController,

          isPassword: true,
          hintText: AppString.enterYouPassword,
          validator: OtherHelper.passwordValidator,
        ),

        /// User Confirm Password here
        CommonText(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          text: AppString.confirmPassword,
          bottom: 8,
          top: 12,
        ),
        CommonTextField(
          borderColor: AppColors.normalGray2,

          controller: controller.confirmPasswordController,

          isPassword: true,
          hintText: AppString.confirmYourPassword,
          validator: (value) =>
              OtherHelper.confirmPasswordValidator(value, controller.passwordController),
        ),
      ],
    );
  }
}
