import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../pages/log/log_controller.dart';
import '../my_text_form_field_widget.dart';

class FloatingPopupWidgetLog extends StatelessWidget {
  const FloatingPopupWidgetLog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LogController>(
      builder: (logCtrl) => FloatingActionButton(
        onPressed: () {
          logCtrl.getDropDownCarItems();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              logCtrl.jdStartDate.value = DateTime.now();
              logCtrl.jdEndDate.value = DateTime.now();
              logCtrl.mnDistanzController.value.clear();
              logCtrl.szRouteController.value.clear();
              logCtrl.szNotizController.value.clear();

              return AlertDialog(
                title: const Text('Logbuch Eingabe'),
                content: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: [
                        _dropDownCars(),
                        const SizedBox(height: 5),
                        Text(
                            DateFormat('dd-MM-yyyy')
                                .format(logCtrl.jdStartDate.value)
                                .toString(),
                            style: kMybodyTextStyleMedium),
                        ElevatedButton(
                          onPressed: () => logCtrl.choosStartDate(),
                          child: const Text('Start Datum'),
                        ),
                        const SizedBox(height: 5),
                        Text(
                            DateFormat('dd-MM-yyyy')
                                .format(logCtrl.jdEndDate.value)
                                .toString(),
                            style: kMybodyTextStyleMedium),
                        ElevatedButton(
                          onPressed: () => logCtrl.choosEndDate(),
                          child: const Text('End Datum'),
                        ),
                        const SizedBox(height: 5),
                        MyTextFormWidget(
                          textInputType: TextInputType.number,
                          szHintText: 'Gefahrene Distanz',
                          szInputStringController:
                              logCtrl.mnDistanzController.value,
                        ),
                        const SizedBox(height: 5),
                        MyTextFormWidget(
                          textInputType: TextInputType.name,
                          szHintText: 'Gefahrene Strecke',
                          szInputStringController:
                              logCtrl.szRouteController.value,
                        ),
                        const SizedBox(height: 5),
                        MyTextFormWidget(
                          textInputType: TextInputType.name,
                          szHintText: 'Notiz',
                          szInputStringController:
                              logCtrl.szNotizController.value,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      // Save the input here
                      logCtrl.addLog();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.grey.shade500,
        child: Icon(
          Icons.add,
          color: Colors.grey.shade900,
          size: 40,
        ),
      ),
    );
  }

  DropdownButtonFormField _dropDownCars() {
    var ctrl = LogController.to;
    var list = ctrl.szDropDownCars;
    // ignore: prefer_typing_uninitialized_variables
    var selectedValue;
    return DropdownButtonFormField(
        decoration: kInputDecorationDropDownMenue,
        itemHeight: 80,
        value: selectedValue,
        items: list.map(
          (item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(letterSpacing: 2, fontSize: kFontSizeDouble),
              ),
            );
          },
        ).toList(),
        onChanged: (value) => ctrl.szCarModelDropdown.value = value);
  }
}
