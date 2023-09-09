import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../pages/settings/settings_model.dart';
import '../../services/settings/settings_database.dart';

import '../../constants.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find<SettingsController>();

  final settingsList = <SettingsModel>[].obs;
  final isLoading = true.obs;
  final mnSettingId = 0.obs;
  final fullNameController = TextEditingController().obs;
  final streetNameController = TextEditingController().obs;
  final postalCityNameController = TextEditingController().obs;
  final maxRangeYearController = TextEditingController().obs;

  Future<SettingsModel> get getFirstSettings async {
    SettingsModel firstSettings = SettingsModel();
    await _getStoredSettings();
    if(settingsList.isNotEmpty){
      firstSettings = settingsList.first;
    }
    return firstSettings;
  }

  Future<void> _getStoredSettings() async {
    final settingData = await SettingsDatabase.getAllSettings();
    if (settingData.isNotEmpty) {
      settingsList.clear();
    }
    settingsList.value = settingData;
    update();
  }

  @override
  void onReady() async {
    await _getStoredSettings();
  }

  @override
  void onClose() {
    fullNameController.close();
    streetNameController.close();
    postalCityNameController.close();
    maxRangeYearController.close();
    settingsList.clear();
  }

  bool _checkEntrys() {
    bool allFieldsHasEntys = true;
    if (fullNameController.value.text == '' ||
        streetNameController.value.text == '' ||
        postalCityNameController.value.text == '' ||
        maxRangeYearController.value.text == '') {
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

  Future<void> saveOrUpdateSettingsData() async {
    if (_checkEntrys()) {
      if (settingsList.isNotEmpty) {
        _updateSettings();
      } else {
        _insertSettings();
      }
    }
    update();
  }

  Future<void> _insertSettings() async {
    if (_checkEntrys()) {
      var maxRangeYear = double.parse(maxRangeYearController.value.text);
      await SettingsDatabase.insertSettings(
        SettingsModel(
          szFullName: fullNameController.value.text,
          szStreet: streetNameController.value.text,
          szPostalCity: postalCityNameController.value.text,
          mnMaxRangeYear: maxRangeYear,
        ),
      );
    }
    await _getStoredSettings();
    update();
    Get.snackbar(
      'Erfolg',
      'Datensatz wurde angelegt',
      backgroundColor: kSnakBarOk,
      snackPosition: SnackPosition.TOP,
    );
  }

  Future<void> _updateSettings() async {
    if (_checkEntrys()) {
      var maxRangeYear = double.parse(maxRangeYearController.value.text);
      await SettingsDatabase.updateSettings(
        SettingsModel(
          mnSettingId: mnSettingId.value,
          szFullName: fullNameController.value.text,
          szStreet: streetNameController.value.text,
          szPostalCity: postalCityNameController.value.text,
          mnMaxRangeYear: maxRangeYear,
        ),
      );
    }
    await _getStoredSettings();
    update();
    Get.snackbar(
      'Erfolg',
      'Datensatz wurde geändert',
      backgroundColor: kSnakBarOk,
      snackPosition: SnackPosition.TOP,
    );
  }

  void deleteSettings(int mnCurrentSettingsId) async {
    if (mnCurrentSettingsId > 0) {
      await SettingsDatabase.deleteSettings(mnCurrentSettingsId);
      Get.snackbar(
        'Erfolg',
        'Datensatz wurde gelöscht',
        backgroundColor: kSnakBarOk,
        snackPosition: SnackPosition.TOP,
      );
    }
    update();
  }
}
