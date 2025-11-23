import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'config/route/app_routes.dart';
import 'config/theme/light_theme.dart';
import 'config/dependency/dependency_injection.dart';
import 'utils/app_utils.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          scaffoldMessengerKey: Utils.scaffoldMessengerKey,
          defaultTransition: Transition.fadeIn,
          theme: themeData,
          transitionDuration: const Duration(milliseconds: 300),
          initialBinding: DependencyInjection(),
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.routes,
        ),
      ),
    );
  }
}
