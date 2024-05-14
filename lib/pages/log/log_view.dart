import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import './log_controller.dart';
import '../../pages/car/car_view.dart';
import '../../utils/my_text_form_field_widget.dart';
import '../../pages/log/log_model.dart';
import '../../constants.dart';
import '../../utils/log/floating_popup_input_log_widget.dart';
import '../../pages/entry/entry_view.dart';

class LogPage extends GetView<LogController> {
  static const namedRoute = '/log-page';
  const LogPage({super.key});

  @override
  Widget build(BuildContext context) {
    var ctrl = LogController.to;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Logbuch Liste'),
        leading: IconButton(
          icon: const Icon(
            Icons.refresh,
          ),
          onPressed: () => ctrl.refreshData(),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(CarPage.namedRoute),
            icon: const Icon(Icons.car_crash),
          ),
          IconButton(
            onPressed: () => Get.toNamed(EntryPage.namedRoute),
            icon: const Icon(Icons.picture_as_pdf),
          ),
        ],
      ),
      floatingActionButton: const FloatingPopupWidgetLog(),
      body: SafeArea(
        child: GetBuilder<LogController>(
          builder: (caCtrl) {
            if (caCtrl.isLoading.value) {
              return const Center(child: Text('Noch keine Daten!'));
            } else {
              return ListView.builder(
                itemCount: caCtrl.logList.length,
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
                              caCtrl.deleteLog(caCtrl.logList[index].mnLogId!),
                        ),
                        SlidableAction(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.black,
                          label: 'Edit',
                          icon: Icons.edit,
                          onPressed: (_) => editDialog(
                              caCtrl, context, caCtrl.logList[index]),
                        ),
                      ],
                    ),
                    child: _myLogItem(context, caCtrl.logList[index]),
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
      LogController logCtrl, BuildContext context, LogModel currentItem) {
    logCtrl.getDropDownCarItems();
    logCtrl.szCarModelDropdown.value =
        currentItem.szCarModel == null ? '???' : currentItem.szCarModel!;
    logCtrl.mnCurrentLogId.value = currentItem.mnLogId!;
    logCtrl.jdStartDate.value =
        currentItem.jdStartDate ?? currentItem.jdStartDate!;
    logCtrl.jdEndDate.value = currentItem.jdEndDate ?? currentItem.jdEndDate!;
    logCtrl.mnDistanzController.value.text =
        currentItem.mnDistanz!.toStringAsFixed(2);
    logCtrl.szRouteController.value.text =
        currentItem.szRoute ?? currentItem.szRoute!;
    logCtrl.szNotizController.value.text =
        currentItem.szNotiz ?? currentItem.szNotiz!;
    AlertDialog dialog = AlertDialog(
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
              const SizedBox(height: 5),
              MyTextFormWidget(
                textInputType: TextInputType.name,
                szHintText: currentItem.mnDistanz!.toStringAsFixed(2),
                szInputStringController: logCtrl.mnDistanzController.value,
              ),
              const SizedBox(height: 5),
              MyTextFormWidget(
                textInputType: TextInputType.name,
                szHintText: currentItem.szRoute,
                szInputStringController: logCtrl.szRouteController.value,
              ),
              const SizedBox(height: 5),
              MyTextFormWidget(
                textInputType: TextInputType.name,
                szHintText: currentItem.szNotiz,
                szInputStringController: logCtrl.szNotizController.value,
              ),
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
            logCtrl.updateLog();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    // Show the AlertDialog widget.
    showDialog(context: context, builder: (context) => dialog);
  }

  //List Item
  Card _myLogItem(
    BuildContext context,
    LogModel item,
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
                Text('Model:', style: kMybodyTextStyleMedium),
                Text('${item.szCarModel}',
                    style: kMyDescriptionTextStyleMedium),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start Datum:', style: kMybodyTextStyleMedium),
                Text(
                    DateFormat('dd-MM-yyyy')
                        .format(item.jdStartDate!)
                        .toString(),
                    style: kMyDescriptionTextStyleMedium),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('End Datum:', style: kMybodyTextStyleMedium),
                Text(
                    DateFormat('dd-MM-yyyy').format(item.jdEndDate!).toString(),
                    style: kMyDescriptionTextStyleMedium),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Distanz:', style: kMybodyTextStyleMedium),
                Text('${item.mnDistanz}', style: kMyDescriptionTextStyleMedium)
              ],
            ),
            const SizedBox(height: 5),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 30,
              direction: Axis.horizontal,
              children: [
                Text('Strecke :', style: kMybodyTextStyleMedium),
                Text('${item.szRoute}', style: kMyDescriptionTextStyleMedium),
              ],
            ),
            const SizedBox(height: 5),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 30,
              direction: Axis.horizontal,
              children: [
                Text('Notiz:', style: kMybodyTextStyleMedium),
                Text('${item.szNotiz}', style: kMyDescriptionTextStyleMedium),
              ],
            ),
            const SizedBox(height: 5),
          ],
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
