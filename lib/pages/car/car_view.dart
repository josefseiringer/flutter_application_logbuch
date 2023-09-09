import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './car_controller.dart';
import '../../pages/settings/settings_view.dart';
import '../../pages/log/log_view.dart';
import '../../utils/my_text_form_field_widget.dart';
import '../../utils/car/floating_popup_input_car_widget.dart';
import '../../pages/car/car_model.dart';
import '../../constants.dart';

class CarPage extends GetView<CarController> {
  static const namedRoute = '/car-page';
  const CarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    var ctrl = CarController.to;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Oldtimer List'),
        leading: IconButton(
          icon: const Icon(
            Icons.refresh,
          ),
          onPressed: () => ctrl.refreshData(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed(SettingsPage.namedRoute),
          ),
          IconButton(
            icon: const Icon(Icons.list_sharp),
            onPressed: () => Get.toNamed(LogPage.namedRoute),
          ),
        ],
      ),
      floatingActionButton: const FloatingPopupWidgetCar(),
      body: SafeArea(
        child: GetBuilder<CarController>(
          builder: (caCtrl) {
            if (caCtrl.isLoading.value) {
              return const Center(child: Text('Noch keine Daten!'));
            } else {
              return ListView.builder(
                itemCount: caCtrl.carList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: const ValueKey(0),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: <Widget>[
                        SlidableAction(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.black,
                          label: 'Delete',
                          icon: Icons.delete,
                          onPressed: (_) =>
                              caCtrl.deleteCar(caCtrl.carList[index].mnCarId!),
                        ),
                        SlidableAction(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.black,
                          label: 'Edit',
                          icon: Icons.edit,
                          onPressed: (_) => editDialog(
                              caCtrl, context, caCtrl.carList[index]),
                        ),
                      ],
                    ),
                    child: _myCarItem(context, caCtrl.carList[index]),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  void editDialog(
      CarController caCtrl, BuildContext context, CarModel currentItem) {
    caCtrl.mnCurrentCarId.value = currentItem.mnCarId!;
    caCtrl.szCarMarkeController.value.text =
        currentItem.szCarMarke ?? currentItem.szCarMarke!;
    caCtrl.szCarModelController.value.text =
        currentItem.szCarModel ?? currentItem.szCarModel!;
    caCtrl.szCarKennzeichenController.value.text =
        currentItem.szCarKennzeichen ?? currentItem.szCarKennzeichen!;
    caCtrl.szCarErstzulassungController.value.text =
        currentItem.szCarErstzulassung ?? currentItem.szCarErstzulassung!;
    caCtrl.szCarFahrgestellnummerController.value.text =
        currentItem.szCarFahrgestellnummer ??
            currentItem.szCarFahrgestellnummer!;
    caCtrl.szCarZulassungsbesitzerController.value.text =
        currentItem.szCarZulassungsbesitzer ??
            currentItem.szCarZulassungsbesitzer!;
    AlertDialog dialog = AlertDialog(
      title: const Text('Oldtimer Eingabe'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            MyTextFormWidget(
              textInputType: TextInputType.name,
              szHintText: '',
              szInputStringController: caCtrl.szCarMarkeController.value,
            ),
            const SizedBox(height: 5),
            MyTextFormWidget(
              textInputType: TextInputType.name,
              szHintText: currentItem.szCarModel,
              szInputStringController: caCtrl.szCarModelController.value,
            ),
            const SizedBox(height: 5),
            MyTextFormWidget(
              textInputType: TextInputType.name,
              szHintText: currentItem.szCarKennzeichen,
              szInputStringController: caCtrl.szCarKennzeichenController.value,
            ),
            const SizedBox(height: 5),
            MyTextFormWidget(
              textInputType: TextInputType.name,
              szHintText: currentItem.szCarFahrgestellnummer,
              szInputStringController:
                  caCtrl.szCarFahrgestellnummerController.value,
            ),
            const SizedBox(height: 5),
            MyTextFormWidget(
              textInputType: TextInputType.name,
              szHintText: currentItem.szCarZulassungsbesitzer,
              szInputStringController:
                  caCtrl.szCarZulassungsbesitzerController.value,
            ),
            const SizedBox(height: 5),
            MyTextFormWidget(
              textInputType: TextInputType.name,
              szHintText: currentItem.szCarErstzulassung,
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
            caCtrl.updateCar();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    // Show the AlertDialog widget.
    showDialog(context: context, builder: (context) => dialog);
  }

  //List Item
  Card _myCarItem(
    BuildContext context,
    CarModel item,
  ) {
    var maxDisplayWidth = MediaQuery.of(context).size.width;
    return Card(
      //elevation: 2,
      shadowColor: Colors.grey.shade300,
      child: Container(
        width: maxDisplayWidth,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text(item.szHabitId!, style: kMybodyTextStyleSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Marke:', style: kMybodyTextStyleMedium),
                Text('${item.szCarMarke}',
                    style: kMyDescriptionTextStyleMedium),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Model:', style: kMybodyTextStyleMedium),
                Text('${item.szCarModel}',
                    style: kMyDescriptionTextStyleMedium),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Kennzeichen:', style: kMybodyTextStyleMedium),
                Text('${item.szCarKennzeichen}',
                    style: kMyDescriptionTextStyleMedium)
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Zulassung :', style: kMybodyTextStyleMedium),
                Text('${item.szCarErstzulassung}',
                    style: kMyDescriptionTextStyleMedium),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('FgNr.:', style: kMybodyTextStyleMedium),
                Text('${item.szCarFahrgestellnummer}',
                    style: kMyDescriptionTextStyleMedium),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Besitzer:', style: kMybodyTextStyleMedium),
                Text('${item.szCarZulassungsbesitzer}',
                    style: kMyDescriptionTextStyleMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
