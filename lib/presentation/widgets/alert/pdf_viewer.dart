import 'dart:io';

import '/const/all_const.dart';

// import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({super.key, this.pdf = "", this.isFile = false});

  final String pdf;
  final bool isFile;

  // getFile() async {
  //   PDFDocument docF = await PDFDocument.fromFile(File(pdf));
  //   PDFDocument docN = await PDFDocument.fromURL(pdf);
  //   return isFile ? docF : docN;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pdf.split("/").last.toUpperCase()),
        backgroundColor: AppColors.appBarColorRetailer,
      ),
      body: Container(
        color: Colors.red,
        height: 100.0.hp,
        width: 100.0.wp,
        // child: PDFViewer(document: getFile()),
        child: isFile
            ? SfPdfViewer.file(File(pdf),
                canShowScrollHead: false, canShowScrollStatus: true)
            : SfPdfViewer.network((pdf),
                canShowScrollHead: false, canShowScrollStatus: true),
      ),
    );
  }
}
