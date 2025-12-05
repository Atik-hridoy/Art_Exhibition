import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/app_colors.dart';

class Utils {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void successSnackBar(String title, String message) {
    _showSnackBar(
      title: title,
      message: message,
      backgroundColor: AppColors.black,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static void errorSnackBar(dynamic title, String message) {
    _showSnackBar(
      title: kDebugMode ? title.toString() : "Oops",
      message: message,
      backgroundColor: AppColors.red,
      snackPosition: SnackPosition.TOP,
    );
  }

  static void _showSnackBar({
    required String title,
    required String message,
    required Color backgroundColor,
    required SnackPosition snackPosition,
  }) {
    // Always use post-frame callback to avoid build phase issues
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final messenger = scaffoldMessengerKey.currentState;
      if (messenger != null) {
        messenger
          ..removeCurrentSnackBar()
          ..showSnackBar(
            _buildSnackBar(
              title: title,
              message: message,
              backgroundColor: backgroundColor,
              snackPosition: snackPosition,
            ),
          );
      }
    });
  }

  static SnackBar _buildSnackBar({
    required String title,
    required String message,
    required Color backgroundColor,
    required SnackPosition snackPosition,
  }) {
    final alignment = snackPosition == SnackPosition.TOP
        ? Alignment.topCenter
        : Alignment.bottomCenter;

    final topMargin = snackPosition == SnackPosition.TOP ? 16.0 : 0.0;
    final bottomMargin = snackPosition == SnackPosition.BOTTOM ? 16.0 : 0.0;

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        top: topMargin,
        bottom: bottomMargin,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: const Duration(seconds: 3),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: const TextStyle(color: AppColors.white),
          ),
        ],
      ),
      dismissDirection: snackPosition == SnackPosition.TOP
          ? DismissDirection.up
          : DismissDirection.down,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      showCloseIcon: true,
      closeIconColor: AppColors.white,
    );
  }
}
