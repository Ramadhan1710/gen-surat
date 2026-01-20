import 'package:get/get.dart';

abstract class BaseViewModel extends GetxController {}

mixin LoadingStateMixin on GetxController {
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void setLoading(bool value) {
    _isLoading.value = value;
  }

  Future<T> executeWithLoading<T>(Future<T> Function() operation) async {
    setLoading(true);
    try {
      return await operation();
    } finally {
      setLoading(false);
    }
  }
}

mixin ErrorHandlingMixin on GetxController {
  final RxString _errorMessage = ''.obs;

  String get errorMessage => _errorMessage.value;
  bool get hasError => _errorMessage.value.isNotEmpty;

  void setError(String message) {
    _errorMessage.value = message;
  }

  void clearError() {
    _errorMessage.value = '';
  }

  Future<T?> executeWithErrorHandling<T>({
    required Future<T> Function() operation,
    String Function(dynamic error)? onError,
  }) async {
    try {
      clearError();
      return await operation();
    } catch (e) {
      setError(onError?.call(e) ?? e.toString());
      return null;
    }
  }
}

mixin SnackbarMixin on GetxController {
  void showSuccess(String message, {String title = 'Berhasil'}) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  void showError(String message, {String title = 'Error'}) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  void showInfo(String message, {String title = 'Info'}) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  void showWarning(String message, {String title = 'Peringatan'}) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }
}

mixin CommonStateMixin on GetxController
    implements LoadingStateMixin, ErrorHandlingMixin {
  @override
  final RxBool _isLoading = false.obs;

  @override
  final RxString _errorMessage = ''.obs;

  @override
  bool get isLoading => _isLoading.value;

  @override
  String get errorMessage => _errorMessage.value;

  @override
  bool get hasError => _errorMessage.value.isNotEmpty;

  @override
  void setLoading(bool value) {
    _isLoading.value = value;
    if (value) clearError();
  }

  @override
  void setError(String message) {
    _errorMessage.value = message;
  }

  @override
  void clearError() {
    _errorMessage.value = '';
  }

  Future<T?> executeAsync<T>({
    required Future<T> Function() operation,
    String Function(dynamic error)? onError,
  }) async {
    setLoading(true);
    try {
      final result = await operation();
      return result;
    } catch (e) {
      setError(onError?.call(e) ?? e.toString());
      return null;
    } finally {
      setLoading(false);
    }
  }

  @override
  Future<T> executeWithLoading<T>(Future<T> Function() operation) async {
    setLoading(true);
    try {
      return await operation();
    } finally {
      setLoading(false);
    }
  }

  @override
  Future<T?> executeWithErrorHandling<T>({
    required Future<T> Function() operation,
    String Function(dynamic error)? onError,
  }) async {
    return executeAsync(operation: operation, onError: onError);
  }
}

mixin FullFeaturedMixin on GetxController
    implements CommonStateMixin, SnackbarMixin {
  @override
  final RxBool _isLoading = false.obs;

  @override
  final RxString _errorMessage = ''.obs;

  @override
  bool get isLoading => _isLoading.value;

  @override
  String get errorMessage => _errorMessage.value;

  @override
  bool get hasError => _errorMessage.value.isNotEmpty;

  @override
  void setLoading(bool value) {
    _isLoading.value = value;
    if (value) clearError();
  }

  @override
  void setError(String message) {
    _errorMessage.value = message;
  }

  @override
  void clearError() {
    _errorMessage.value = '';
  }

  @override
  void showSuccess(String message, {String title = 'Berhasil'}) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void showError(String message, {String title = 'Error'}) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void showInfo(String message, {String title = 'Info'}) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void showWarning(String message, {String title = 'Peringatan'}) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  @override
  Future<T?> executeAsync<T>({
    required Future<T> Function() operation,
    void Function()? onSuccess,
    String Function(dynamic error)? onError,
    bool showErrorSnackbar = true,
  }) async {
    setLoading(true);
    try {
      final result = await operation();
      onSuccess?.call();
      return result;
    } catch (e) {
      final errorMsg = onError?.call(e) ?? e.toString();
      setError(errorMsg);
      if (showErrorSnackbar) {
        showError(errorMsg);
      }
      return null;
    } finally {
      setLoading(false);
    }
  }

  @override
  Future<T> executeWithLoading<T>(Future<T> Function() operation) async {
    setLoading(true);
    try {
      return await operation();
    } finally {
      setLoading(false);
    }
  }

  @override
  Future<T?> executeWithErrorHandling<T>({
    required Future<T> Function() operation,
    String Function(dynamic error)? onError,
  }) async {
    return executeAsync(operation: operation, onError: onError);
  }
}
