import 'package:get/get.dart';
import '../car/car_view.dart';
import 'login_service.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();

  var szInputUserName = ''.obs;

  @override
  void onReady() {
    _getStoredUser();
    super.onReady();
  }

  void saveUserLocal() {
    if (szInputUserName.isNotEmpty) {
      if (LoginService().saveLoginLocal(szInputUserName.value)) {
        Get.snackbar('Login', 'You are logged in...');
        //go to Car list
        Get.offAllNamed(CarPage.namedRoute);
      }
    }
    update();
  }

  void _getStoredUser() {
    var user = LoginService().loadUserName();
    if (user != '') {
      Get.offAllNamed(CarPage.namedRoute);
    }
  }
}
