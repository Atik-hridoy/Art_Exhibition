import 'package:flutter/material.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

import '../../config/route/app_routes.dart';
import 'package:get/get.dart';
import '../../services/storage/storage_services.dart';
import '../../utils/constants/app_images.dart';
import '../../component/image/common_image.dart';
import '../../utils/log/app_log.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  /// Check login status and navigate accordingly
  void _checkLoginStatus() async {
    // Wait for splash screen display
    await Future.delayed(const Duration(seconds: 3));
    
    try {
      // Load stored data first
      await LocalStorage.getAllPrefData();
      
      // Check if user should be auto-logged in
      if (LocalStorage.shouldAutoLogin()) {
        appLog("Auto-login successful for user: ${LocalStorage.myName}", source: "SplashScreen");
        
        // Navigate directly to home screen
        Get.offAllNamed(AppRoutes.userHomeScreen);
      } else {
        appLog("No valid login session found", source: "SplashScreen");
        
        // Navigate to welcome screen
        Get.offAllNamed(AppRoutes.welcome);
      }
    } catch (e) {
      appLog("Error checking login status: $e", source: "SplashScreen");
      
      // Fallback to welcome screen on error
      Get.offAllNamed(AppRoutes.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 120,
          width: 120,
          child: CommonImage(
            fill: BoxFit.cover,
            imageSrc: AppImages.logo,
          ).center,
        ),
      ),
    );
  }
}
