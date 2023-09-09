import 'package:flutter/material.dart';
import 'package:flutter_application_pdf/pages/car/car_view.dart';
import 'package:flutter_application_pdf/utils/setting/my_text_field.dart';
import 'package:get/get.dart';
import './settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  static const namedRoute = '/settings-page';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings Page'),
      ),
      body: GetBuilder<SettingsController>(
        builder: (SettingsController setCtrl) => ListView(
          padding: const EdgeInsets.all(20),
          children: _settingsList(setCtrl),
        ),
      ),
    );
  }

  List<Widget> _settingsList(SettingsController setCtrl) {
    var resultOfSettings = setCtrl.settingsList;
    if (resultOfSettings.isNotEmpty) {
      var firstSettingsData = resultOfSettings.first;
      if (firstSettingsData.mnSettingId != null) {
        setCtrl.mnSettingId.value = firstSettingsData.mnSettingId!;
      }
      setCtrl.fullNameController.value.text = firstSettingsData.szFullName!;
      setCtrl.streetNameController.value.text = firstSettingsData.szStreet!;
      setCtrl.postalCityNameController.value.text =
          firstSettingsData.szPostalCity!;
      setCtrl.maxRangeYearController.value.text =
          firstSettingsData.mnMaxRangeYear!.toStringAsFixed(2);
    }
    return [
      Column(
        children: [
          MyTextField(
            myController: setCtrl.fullNameController.value,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            hintText: 'Enter Full Name',
            myTextInputType: TextInputType.name,
            suffixIcon: const Icon(Icons.person),
          ),
          const SizedBox(height: 20),
          MyTextField(
            myController: setCtrl.streetNameController.value,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            hintText: 'Enter Street and Number',
            myTextInputType: TextInputType.name,
            suffixIcon: const Icon(Icons.house),
          ),
          const SizedBox(height: 20),
          MyTextField(
            myController: setCtrl.postalCityNameController.value,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            hintText: 'Enter Postal and Zip',
            myTextInputType: TextInputType.name,
            suffixIcon: const Icon(Icons.house),
          ),
          const SizedBox(height: 20),
          MyTextField(
            myController: setCtrl.maxRangeYearController.value,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            hintText: 'Enter range Year',
            myTextInputType: TextInputType.number,
            suffixIcon: const Icon(Icons.directions_car),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  var resultOfSettings = setCtrl.settingsList;
                  if (resultOfSettings.isNotEmpty) {
                    var firstSettingsData = resultOfSettings.first;
                    if (firstSettingsData.mnSettingId != null) {
                      setCtrl.mnSettingId.value =
                          firstSettingsData.mnSettingId!;
                      setCtrl.deleteSettings(
                        setCtrl.mnSettingId.value,
                      );
                    }
                  }
                  Get.offAndToNamed(CarPage.namedRoute);
                },
                child: const Text('Delete'),
              ),
              ElevatedButton(
                onPressed: () {
                  setCtrl.saveOrUpdateSettingsData();
                  Get.offAndToNamed(CarPage.namedRoute);
                },
                child: const Text('Save'),
              ),
            ],
          )
        ],
      ),
    ];
  }
}
