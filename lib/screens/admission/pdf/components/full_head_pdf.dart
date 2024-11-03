import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../config/pdf/widget/pdf_text_widget.dart';

class FullHeadPdfText extends pw.StatelessWidget {
  final String text;
  final PdfColor backgroundColor,textColor;
   FullHeadPdfText({
     required this.text,
     required this.backgroundColor,
     required this.textColor
   });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      width: Get.width,
      padding: const pw.EdgeInsets.all(6.0),
      color: backgroundColor,
      child: PdfTextWidget(
          text: text,
          color: PdfColors.white,
          size: 13.0,
          isBold: true,
        textAlign: pw.TextAlign.start
      )
    );
  }
}
