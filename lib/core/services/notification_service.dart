import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:get/get.dart';

abstract class NotificationService {
  void showSuccess(String message);
  void showError(String message);
  void showWarning(String message);
  void showInfo(String message);
}

class GetXNotificationService implements NotificationService {
  @override
  void showSuccess(String message) {
    Get.snackbar(
      'Sukses',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
  
  @override
  void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
    );
  }
  
  @override
  void showWarning(String message) {
    Get.snackbar(
      'Peringatan',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.warning.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
    );
  }
  
  @override
  void showInfo(String message) {
    Get.snackbar(
      'Info',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.info.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}