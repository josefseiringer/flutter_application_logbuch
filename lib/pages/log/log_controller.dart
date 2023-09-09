import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../pages/log/log_model.dart';
import '../../constants.dart';
import '../../services/car/car_database.dart';
import '../../services/log/log_database.dart';

class LogController extends GetxController {
  static LogController get to => Get.find<LogController>();
  final logList = <LogModel>[].obs;
  final szDropDownCars = <String>[].obs;
  final szCarModelDropdown = ''.obs;
  final isLoading = true.obs;
  final mnCurrentLogId = 0.obs;
  final jdStartDate = DateTime.now().obs;
  final jdEndDate = DateTime.now().obs;
  final mnDistanzController = TextEditingController().obs;
  final szRouteController = TextEditingController().obs;
  final szNotizController = TextEditingController().obs;

  @override
  void onInit() {
    refreshData();
    super.onInit();
  }

  choosStartDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: jdStartDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != jdStartDate.value) {
      jdStartDate.value = pickedDate;
    }
  }

  choosEndDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: jdEndDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != jdEndDate.value) {
      jdEndDate.value = pickedDate;
    }
  }

  @override
  void onReady() {
    getDropDownCarItems();
  }

  @override
  void onClose() {
    mnDistanzController.close();
    szRouteController.close();
    szNotizController.close();
  }

  void refreshData() async {
    final logData = await LogsDatabase.getAllLogs();
    if (logData.isNotEmpty) {
      logList.clear();
    }
    logList.value = logData;
    isLoading.value = false;
    update();
  }

  void getDropDownCarItems() async {
    if (szDropDownCars.isNotEmpty) {
      szDropDownCars.clear();
    }
    final carData = await CarsDatabase.getAllCars();
    for (var item in carData) {
      var concateItem = '${item.szCarMarke!}/${item.szCarModel!}';
      szDropDownCars.add(concateItem);
    }
    update();
  }

  Future<void> addLog() async {
    if (_checkEntrys()) {
      var mnDistanz = double.parse(mnDistanzController.value.text);
      await LogsDatabase.insertLog(
        LogModel(
          szCarModel: szCarModelDropdown.value,
          jdStartDate: jdStartDate.value,
          jdEndDate: jdEndDate.value,
          mnDistanz: mnDistanz,
          szRoute: szRouteController.value.text,
          szNotiz: szNotizController.value.text,
        ),
      );
    }
    refreshData();
    update();
  }

  void updateLog() async {
    if (_checkEntrys()) {
      var mnDistanz = double.parse(mnDistanzController.value.text);
      await LogsDatabase.updateLog(
        LogModel(
          mnLogId: mnCurrentLogId.value,
          szCarModel: szCarModelDropdown.value,
          jdStartDate: jdStartDate.value,
          jdEndDate: jdEndDate.value,
          mnDistanz: mnDistanz,
          szRoute: szRouteController.value.text,
          szNotiz: szNotizController.value.text,
        ),
      );
    }
    refreshData();
    update();
  }

  void deleteLog(int mnCurrentLogId) async {
    await LogsDatabase.deleteLog(mnCurrentLogId);
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
    if (mnDistanzController.value.text == '' ||
        szRouteController.value.text == '' ||
        szCarModelDropdown.value == '') {
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
