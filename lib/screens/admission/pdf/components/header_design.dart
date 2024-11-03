import 'dart:typed_data';
import 'package:legends_schools_admin/config/res/app_string.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../config/pdf/color/pdf_color.dart';

class RegistrationHeaderPdf extends pw.StatelessWidget{
  final pw.MemoryImage image;
  final Uint8List? pickedImage;
  // final PdfColor blueColor;
  // final PdfColor redColor;

  RegistrationHeaderPdf({
    required this.image,
    // required this.blueColor,
    // required this.redColor,
    this.pickedImage,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      children: [
        if (pickedImage != null)
        pw.Container(
          width: 80,
          child: pw.Image(image),
        ),
        pw.SizedBox(width: 20),
        pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Container(
              width: 300,
              alignment: pw.Alignment.center,
              child: pw.Text(
                AppString.institute,
                style: pw.TextStyle(
                  color: blueColor,
                  fontSize: 21,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Container(
              width: 300,
              padding: const pw.EdgeInsets.all(4.0),
              alignment: pw.Alignment.center,
              child: pw.Text(
                "Your Preparation is our Responsibility",
                style: pw.TextStyle(
                  color: blueColor,
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Container(
              width: 300,
              padding: const pw.EdgeInsets.all(2.0),
              alignment: pw.Alignment.center,
              child: pw.Text(
                "Email: ${AppString.email}",
                style: pw.TextStyle(
                  color: redColor,
                ),
              ),
            ),
            pw.Container(
              width: 300,
              padding: const pw.EdgeInsets.all(2.0),
              alignment: pw.Alignment.center,
              child: pw.Text("Whatsapp & Mobile: ${AppString.phone}"),
            ),
            pw.Container(
              width: 300,
              padding: const pw.EdgeInsets.all(2.0),
              alignment: pw.Alignment.center,
              child: pw.Text("Phone: ${AppString.officePhone}"),
            ),
            pw.SizedBox(height: 20),
          ],
        ),
        pw.SizedBox(width: 20),
        if (pickedImage != null)
          pw.Container(
            width: 80,
            height: 80,
            padding: const pw.EdgeInsets.all(10.0),
            child: pw.Image(pw.MemoryImage(pickedImage!)),
          ),
      ],
    );
  }
}
