import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewmodels/auth/auth_viewmodel.dart';
import '../route_names.dart';

/// Middleware untuk mengecek apakah user sudah login
class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authViewModel = Get.find<AuthViewModel>();
    
    // Jika user belum login, redirect ke login page
    if (!authViewModel.isLoggedIn) {
      return const RouteSettings(name: RouteNames.login);
    }
    
    return null;
  }
}

/// Middleware untuk mencegah user yang sudah login mengakses login page
class LoginMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authViewModel = Get.find<AuthViewModel>();
    
    // Jika user sudah login, redirect ke home
    if (authViewModel.isLoggedIn) {
      return const RouteSettings(name: RouteNames.home);
    }
    
    return null;
  }
}
