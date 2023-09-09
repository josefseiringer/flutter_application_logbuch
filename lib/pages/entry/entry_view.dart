import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_pdf/pages/settings/settings_controller.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'entry_controller.dart';
import '../../pages/log/log_view.dart';

class EntryPage extends GetView<EntryController> {
  static const namedRoute = '/entry-page';
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Printing Log'),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(LogPage.namedRoute),
            icon: const Icon(Icons.list),
          ),
        ],
      ),
      body: GetBuilder<EntryController>(
        builder: (EntryController entryCtrl) => PdfPreview(
          build: (format) => _generatePdf(format, entryCtrl),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, EntryController entryCtrl) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.ListView(
            padding: const pw.EdgeInsets.all(20),
            children: [
              pw.SizedBox(
                width: double.infinity,
                child: pw.Text(
                  'Logbuch 2023',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      font: font,
                      color: const PdfColor.fromInt(0x00191257),
                      fontSize: 25),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  entryCtrl.szFullName.value,
                  style: pw.TextStyle(
                    font: font,
                    fontSize: kFontSizeDoublePdfSettingsUser,
                  ),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  entryCtrl.szStreet.value,
                  style: pw.TextStyle(
                    font: font,
                    fontSize: kFontSizeDoublePdfSettingsUser,
                  ),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  entryCtrl.szPostalCity.value,
                  style: pw.TextStyle(
                    font: font,
                    fontSize: kFontSizeDoublePdfSettingsUser,
                  ),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  'Kilometerlimit: ${entryCtrl.mnMaxKilometer.value.toStringAsFixed(0)} km',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: kFontSizeDoublePdfSettingsUser,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.ListView(
                children: [
                  pw.Divider(color: const PdfColor.fromInt(0x00ABC0BE)),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: listLogData(font, entryCtrl)),
                  pw.SizedBox(height: 20),
                  pw.Divider(color: const PdfColor.fromInt(0x00ABC0BE)),
                  pw.Align(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      'Erstellt am ${DateFormat('dd-MM-yyyy').format(DateTime.now()).toString()}',
                      style: pw.TextStyle(
                          font: font,
                          fontSize: 20,
                          color: const PdfColor.fromInt(0x00191257)),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  List<pw.Widget> listLogData(pw.Font font, EntryController entryCtrl) {
    List<pw.SpanningWidget> dataListSpanningWidget = [];
    List<String> dataStringLogListe = [];
    dataStringLogListe = entryCtrl.logStringList;
    if (dataStringLogListe.isNotEmpty) {
      for (var logLineElement in dataStringLogListe) {
        var spanningItem = pw.Text(
          logLineElement,
          style: pw.TextStyle(
            font: font,
            fontSize: 12,
          ),
        );
        dataListSpanningWidget.add(spanningItem);
        dataListSpanningWidget.add(
          pw.Divider(
            color: const PdfColor.fromInt(0x00ABC0BE),
          ),
        );
      }
    }
    return dataListSpanningWidget;
  }
}
