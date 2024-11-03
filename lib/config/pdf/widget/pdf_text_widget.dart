import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfTextWidget extends pw.StatelessWidget {
  final String text;
  final PdfColor color;
  final double size;
  final bool isBold;
   pw.TextAlign textAlign;

   PdfTextWidget({
    required this.text,
    required this.color,
    required this.size,
    required this.isBold,
     this.textAlign = pw.TextAlign.center
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Text(
      text,
      textAlign: textAlign,
      style: pw.TextStyle(
        color: color,
        fontSize: size,
        fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
      ),
    );
  }
}