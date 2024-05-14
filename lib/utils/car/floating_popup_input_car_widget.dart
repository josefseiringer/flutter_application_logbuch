import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../my_text_form_field_widget.dart';
import '../../../pages/car/car_controller.dart';

class FloatingPopupWidgetCar extends StatelessWidget {
  const FloatingPopupWidgetCar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarController>(
      builder: (caCtrl) => FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              caCtrl.szCarMarkeController.value.clear();
              caCtrl.szCarModelController.value.clear();
              caCtrl.szCarKennzeichenController.value.clear();
              caCtrl.szCarErstzulassungController.value.clear();
              caCtrl.szCarFahrgestellnummerController.value.clear();
              caCtrl.szCarZulassungsbesitzerController.value.clear();
              return AlertDialog(
                title: const Text('Oldtimer Eingabe'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      MyTextFormWidget(
                        textInputType: TextInputType.name,
                        szHintText: 'Marke',
                        szInputStringController:
                            caCtrl.szCarMarkeController.value,
                      ),
                      const SizedBox(height: 5),
                      MyTextFormWidget(
                        textInputType: TextInputType.name,
                        szHintText: 'Model',
                        szInputStringController:
                            caCtrl.szCarModelController.value,
                      ),
                      const SizedBox(height: 5),
                      MyTextFormWidget(
                        textInputType: TextInputType.name,
                        szHintText: 'Kennzeichen',
                        szInputStringController:
                            caCtrl.szCarKennzeichenController.value,
                      ),
                      const SizedBox(height: 5),
                      MyTextFormWidget(
                        textInputType: TextInputType.name,
                        szHintText: 'Fahrgestellnummer',
                        szInputStringController:
                            caCtrl.szCarFahrgestellnummerController.value,
                      ),
                      const SizedBox(height: 5),
                      MyTextFormWidget(
                        textInputType: TextInputType.name,
                        szHintText: 'Besitzer',
                        szInputStringController:
                            caCtrl.szCarZulassungsbesitzerController.value,
                      ),
                      const SizedBox(height: 5),
                      MyTextFormWidget(
                        textInputType: TextInputType.name,
                        szHintText: 'Erstzulassung',
                        szInputStringController:
                            caCtrl.szCarErstzulassungController.value,
                      ),
                      const SizedBox(height: 5),
                    ],
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
                      caCtrl.addCar();
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
}
