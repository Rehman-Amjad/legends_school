import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_schools_admin/config/component/app_text_widget.dart';
import 'package:legends_schools_admin/config/res/app_assets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

class PdfPreviewScreen extends StatelessWidget {
  final pw.Document pdf;
  final String pdfName;
  const PdfPreviewScreen({super.key, required this.pdf, required this.pdfName});

  @override
  Widget build(BuildContext context) {
    debugPrint(pdfName);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        title: Text("Preview"),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: Get.width,
              margin: const EdgeInsets.all(10.0),
              child: PdfPreview(
                build: (PdfPageFormat pageFormat) => pdf.save(),
                allowSharing: true,
                allowPrinting: true,
                canChangePageFormat: true,
                canChangeOrientation: true,
                initialPageFormat: PdfPageFormat.a4,
                pdfFileName: pdfName,
              ),
            ),
          ),
          Expanded(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.asset(AppAssets.adminImagePath,width: 50.0,height: 50.0,),
              SizedBox(height: 20.0,),
              AppTextWidget(text: "Please wait.. it takes few minutes", color: Colors.black,
                  fontSize: 18.0)


            ],))
        ],
      ),
    );
  }
}
