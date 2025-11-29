import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nextgen_pdf_editor/nextgen_pdf_editor.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(const MyApp());
}

/// Entry widget for the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewOrion PDF Editor Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Home screen that allows picking, editing, and previewing a PDF.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _pdfFile; // The selected or edited PDF file
  bool _isLoading = false; // Controls loading indicator
  final PdfViewerController _pdfViewerController =
      PdfViewerController(); // Controls PDF viewer

  /// Allows the user to pick a PDF file from device storage
  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    }
  }

  /// Launches the PDF editor on the selected PDF file
  Future<void> _editPDF() async {
    if (_pdfFile == null) return;

    setState(() => _isLoading = true);

    File? editedFile = await NGPdf.openEditor(context, _pdfFile!);

    // Reset file reference
    setState(() {
      _pdfFile = editedFile;
      _isLoading = false;
    });
  }

  Future<void> _savePDF() async {
    if (_pdfFile == null) return;
    setState(() => _isLoading = true);

    try {
      await NGPdf.lauchPdf(_pdfFile!);
    } catch (e) {
      debugPrint("Error saving PDF: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Editor Example')),

      body: Column(
        children: [
          const SizedBox(height: 20),

          // Button to pick PDF
          ElevatedButton(onPressed: _pickPDF, child: const Text('Pick PDF')),

          const SizedBox(height: 10),

          // Button to open the editor
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _editPDF,
                child: const Text('Edit PDF'),
              ),
              ElevatedButton(
                onPressed: _savePDF,
                child: const Text('Save PDF'),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Show loading or PDF preview
          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _pdfFile == null
                    ? const Center(child: Text('No PDF selected'))
                    : SfPdfViewer.file(
                      _pdfFile!,
                      controller: _pdfViewerController,
                      canShowPaginationDialog: true,
                      pageLayoutMode: PdfPageLayoutMode.single,
                      canShowScrollHead: true,
                      canShowScrollStatus: true,
                    ),
          ),
        ],
      ),
    );
  }
}
