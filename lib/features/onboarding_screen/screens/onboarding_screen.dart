import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../component/image/common_image.dart';
import '../../../utils/constants/app_images.dart';
import '../controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        // physics: const BouncingScrollPhysics(), //
        controller: controller.pageController,

        children: [
          CommonImage(
            height: 550.h,
            fill: BoxFit.fill,
            imageSrc: AppImages.onboardingOne,
          ),
          CommonImage(
            height: 550.h,
            fill: BoxFit.fill,
            imageSrc: AppImages.onboardingTwo,
          ),
          CommonImage(
            height: 550.h,
            fill: BoxFit.fill,
            imageSrc: AppImages.onboardingThree,
          ),
        ],
      ),
    );
  }
}
