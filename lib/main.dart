import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:untitled/upload.dart';

import 'data_import.dart';
import 'firebase_options.dart';

class PDFGenerator extends StatefulWidget {
  const PDFGenerator({super.key});

  @override
  _PDFGeneratorState createState() => _PDFGeneratorState();
}

class _PDFGeneratorState extends State<PDFGenerator> {
  final pdf = pw.Document();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Generator'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // generatePDF();
                // savePDF();
                fetchDataAndCreatePdf();
              },
              child: const Text('Generate PDF'),
            ),
            ElevatedButton(
              onPressed: () {
                // generatePDF();
                // savePDF();
                uploadFirestore();
              },
              child: const Text("Upload to Firestore"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    home: PDFGenerator(),
  ));
}
