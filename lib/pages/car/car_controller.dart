import 'package:flutter/widgets.dart';
import '../../constants.dart';
import '../../services/car/car_database.dart';
import 'package:get/get.dart';
import '../../pages/car/car_model.dart';

class CarController extends GetxController {
  static CarController get to => Get.find<CarController>();
  final carList = <CarModel>[].obs;
  final isLoading = true.obs;
  final szCarMarkeController = TextEditingController().obs;
  final szCarModelController = TextEditingController().obs;
  final szCarKennzeichenController = TextEditingController().obs;
  final szCarFahrgestellnummerController = TextEditingController().obs;
  final szCarZulassungsbesitzerController = TextEditingController().obs;
  final szCarErstzulassungController = TextEditingController().obs;
  final mnCurrentCarId = 0.obs;

  @override
  void onInit() {
    refreshData();
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    szCarMarkeController.close();
    szCarModelController.close();
    szCarKennzeichenController.close();
    szCarFahrgestellnummerController.close();
    szCarZulassungsbesitzerController.close();
    szCarErstzulassungController.close();
  }

  void refreshData() async {
    final carData = await CarsDatabase.getAllCars();
    if (carData.isNotEmpty) {
      carList.clear();
    }
    carList.value = carData;
    isLoading.value = false;
    update();
  }

  Future<void> addCar() async {
    if (_checkEntrys()) {
      await CarsDatabase.insertCar(CarModel(
          szCarMarke: szCarMarkeController.value.text,
          szCarModel: szCarModelController.value.text,
          szCarKennzeichen: szCarKennzeichenController.value.text,
          szCarFahrgestellnummer: szCarFahrgestellnummerController.value.text,
          szCarZulassungsbesitzer: szCarZulassungsbesitzerController.value.text,
          szCarErstzulassung: szCarErstzulassungController.value.text));
    }
    refreshData();
    update();
  }

  void updateCar() async {
    if (_checkEntrys()) {
      await CarsDatabase.updateCar(
        CarModel(
            mnCarId: mnCurrentCarId.value,
            szCarMarke: szCarMarkeController.value.text,
            szCarModel: szCarModelController.value.text,
            szCarKennzeichen: szCarKennzeichenController.value.text,
            szCarFahrgestellnummer: szCarFahrgestellnummerController.value.text,
            szCarZulassungsbesitzer:
                szCarZulassungsbesitzerController.value.text,
            szCarErstzulassung: szCarErstzulassungController.value.text),
      );
    }
    refreshData();
    update();
  }

  void deleteCar(int mnCurrentCarId) async {
    await CarsDatabase.deleteCar(mnCurrentCarId);
    refreshData();
    update();
    Get.snackbar(
      'Erfolg',
      'Datensatz wurde gelöscht',
      backgroundColor: kSnakBarOk,
      snackPosition: SnackPosition.TOP,
    );
  }

  bool _checkEntrys() {
    bool allFieldsHasEntys = true;
    if (szCarMarkeController.value.text == '' ||
        szCarModelController.value.text == '' ||
        szCarKennzeichenController.value.text == '' ||
        szCarFahrgestellnummerController.value.text == '' ||
        szCarZulassungsbesitzerController.value.text == '' ||
        szCarErstzulassungController.value.text == '') {
      allFieldsHasEntys = false;
      Get.snackbar(
        'Fehler',
        'Alle Felder sind Pflichtfelder',
        backgroundColor: kSnakBarError,
        snackPosition: SnackPosition.TOP,
      );
    }
    return allFieldsHasEntys;
  }
}
