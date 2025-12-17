import 'app_bindings.dart';
import 'data_bindings.dart';
import 'domain_bindings.dart';
import 'global_bindings.dart';

void initDependencies() {
  GlobalBindings().dependencies();
  DataBindings().dependencies();
  DomainBindings().dependencies();
  AppBindings().dependencies();
}
