import 'app_bindings.dart';
import 'data_bindings.dart';
import 'domain_bindings.dart';

/// Initialize all dependencies untuk aplikasi
/// Dipanggil di main() sebelum runApp()
void initDependencies() {
  // Register semua bindings
  DataBindings().dependencies();
  DomainBindings().dependencies();
  AppBindings().dependencies();
}