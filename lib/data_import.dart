import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:untitled/model.dart';

void fetchDataAndCreatePdf() async {
  final databaseReference = FirebaseFirestore.instance.collection('data').get();
  databaseReference.then((value) {
    List<DataModel> data = [];
    int totalAmount= 0;
    for (var element in value.docs) {
      data.add(DataModel.fromJson(element.data()));
    }
    createPdf(data);
  });


}

void createPdf(var data) async {
  print('Creating PDF with data: $data'); // Debug statement
  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [
        pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(children: [
              pw.Header(
                outlineColor: PdfColors.black,
                child: pw.Text('Name', style: const pw.TextStyle(fontSize: 16)),
              ),
              pw.Header(
                outlineColor: PdfColors.black,
                child:
                    pw.Text('Amount', style: const pw.TextStyle(fontSize: 16)),
              )
            ]),
            for (var i in data)
              pw.TableRow(
                children: [
                  pw.Text(i.name, style: const pw.TextStyle(fontSize: 16)),
                  pw.Text(i.marks.toString(),
                      style: const pw.TextStyle(fontSize: 16)),
                ],
              ),
          ],
        ),
        pw.Text('Your data: $data', style: const pw.TextStyle(fontSize: 16)),
        pw.Text('Your data: $data', style: const pw.TextStyle(fontSize: 16)),
      ])),
    ),
  );

  final output = await getExternalStorageDirectory();
  print('Output directory: ${output!.path}'); // Debug statement

  final file = File("${output.path}/example.pdf");
  print(file.path); // Debug statement
  await file.writeAsBytes(await pdf.save());
  print('PDF created successfully.'); // Debug statement
}
