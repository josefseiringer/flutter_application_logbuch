import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../settings/settings_model.dart';
import '../../pages/settings/settings_controller.dart';
import '../../services/log/log_database.dart';

class EntryController extends GetxController {
  static EntryController get to => Get.find<EntryController>();
  final logStringList = <String>[].obs; 
  final szFullName = ''.obs;
  final szStreet = ''.obs;
  final szPostalCity = ''.obs;
  final mnMaxKilometer = 0.0.obs;
  final szLogListYear = ''.obs;

  @override
  void onReady() async {
    await logListAsync();
  }

  @override
  void onClose() {
    logStringList.clear();
  }

  Future<void> logListAsync() async {
    //Settings Data
    var setCtrl = SettingsController.to;
    SettingsModel setSettings = await setCtrl.getFirstSettings;
    final settingsUser = setSettings;
    szFullName.value = settingsUser.szFullName!;
    szStreet.value = settingsUser.szStreet!;
    szPostalCity.value = settingsUser.szPostalCity!;
    mnMaxKilometer.value = settingsUser.mnMaxRangeYear!;
    //Loglist Data
    List<String> logString = [];
    final logData = await LogsDatabase.getAllLogs();
    logData.sort((a, b) => a.jdStartDate!.compareTo(b.jdStartDate!));
    if (logData.isNotEmpty) {
    for (var log in logData) {
      var szStartFormatDate =
          DateFormat('dd-MM-yyyy').format(log.jdStartDate!).toString();
      var szEndFormatDate =
          DateFormat('dd-MM-yyyy').format(log.jdEndDate!).toString();
      var szVonBisDateString = '$szStartFormatDate bis $szEndFormatDate';
      var szCarModelText = '${log.szCarModel}';
      var szRouteText = log.szRoute;
      var szDistanzText = log.mnDistanz!.toStringAsFixed(2);
      var szSampleTextLine =
          '$szVonBisDateString $szCarModelText $szRouteText gefahren $szDistanzText km.';
      logString.add(szSampleTextLine);
    }
  }
    logStringList.value = logString;
    update();
  }
}
