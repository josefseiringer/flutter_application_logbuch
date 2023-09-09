import 'package:get/get.dart';
import './pages/car/car_controller.dart';
import './pages/entry/entry_controller.dart';
import './pages/log/log_controller.dart';
import './pages/settings/settings_controller.dart';

class SampleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarController>(() => CarController(),fenix: true);
    Get.lazyPut<SettingsController>(() => SettingsController(),fenix: true);
    Get.lazyPut<LogController>(() => LogController(), fenix: true);
    Get.lazyPut<EntryController>(() => EntryController(),fenix: true);
  }
}
