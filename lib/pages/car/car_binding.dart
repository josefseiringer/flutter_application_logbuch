import 'package:get/get.dart';
import 'car_controller.dart';

class CarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarController>(() => CarController());
  }
}
