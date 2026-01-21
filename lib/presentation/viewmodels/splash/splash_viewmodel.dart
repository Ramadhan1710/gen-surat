import 'dart:async';
import 'dart:developer';

import 'package:gen_surat/presentation/routes/route_names.dart';
import 'package:gen_surat/presentation/viewmodels/auth/auth_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/base/base_viewmodel.dart';
import 'package:get/get.dart';

class SplashViewModel extends BaseViewModel with LoadingStateMixin {
  final AuthViewModel _authViewModel;

  SplashViewModel({required AuthViewModel authViewModel})
    : _authViewModel = authViewModel;

  static const int splashDuration = 3;

  Future<void> initialize() async {
    await executeWithLoading(() async {
      await Future.delayed(const Duration(seconds: splashDuration));

      final targetRoute = await _determineTargetRoute();

      _navigateToRoute(targetRoute);
    });
  }

  Future<String> _determineTargetRoute() async {
    if (!_authViewModel.isLoggedIn) {
      log('User not logged in, redirecting to home');
      return RouteNames.home;
    }

    await _ensureProfileLoaded();

    final role = _authViewModel.userRole;
    final route = _getRouteByRole(role);

    log('User role: $role, redirecting to: $route');
    return route;
  }

  Future<void> _ensureProfileLoaded() async {
    if (_authViewModel.profile == null && _authViewModel.currentUser != null) {
      log('Fetching user profile...');
      await _authViewModel.fetchProfile(_authViewModel.currentUser!.id);
    }
  }

  String _getRouteByRole(String role) {
    switch (role) {
      case 'admin':
        return RouteNames.adminHome;
      case 'pengurus':
        return RouteNames.pengurusHome;
      case 'anggota':
        return RouteNames.anggotaHome;
      case 'ranting':
        return RouteNames.rantingHome;
      case 'sekretaris':
        return RouteNames.sekretarisHome;
      default:
        return RouteNames.home;
    }
  }

  void _navigateToRoute(String routeName) {
    Get.offAllNamed(routeName);
  }
}
