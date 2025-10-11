import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  colorSchemeSeed: AppColors.primaryColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    centerTitle: true,
  ),
);
