import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../config/pdf/color/pdf_color.dart';
import '../../../../config/pdf/widget/pdf_text_widget.dart';

class Table2columnPdf extends pw.StatelessWidget{
  final text1,text2;
   PdfColor color1,color2,text1Color,text2Color;
   double flex1,flex2;
   bool isText1,isText2;
   pw.TextAlign textAlign1,textAlign2;


  Table2columnPdf({
  required this.text1,
  required this.text2,
   this.color1 = PdfColors.white,
   this.color2 = PdfColors.white,
    this.text1Color = PdfColors.black,
    this.text2Color = PdfColors.black,
    this.flex1 = 1,
    this.flex2 = 1,
    this.isText1 = true,
    this.isText2 = true,
    this.textAlign1 = pw.TextAlign.center,
    this.textAlign2 = pw.TextAlign.center,
});

  double? textSize = 10.0;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black,width: 1.0),
      columnWidths: {
        0: pw.FlexColumnWidth(flex1),
        1: pw.FlexColumnWidth(flex2),
      },
        children: [
        pw.TableRow(
          children: [

            pw.Container(
              padding: const pw.EdgeInsets.all(5.0),
              decoration: pw.BoxDecoration(
                color: color1
              ),
              child: PdfTextWidget(
                  text: text1 ?? "error",
                  textAlign: textAlign1,
                  color:text1 !=null ? text1Color : redColor,
                  size: textSize!,
                  isBold: isText1
              ),
            ),

            pw.Container(
                padding: const pw.EdgeInsets.all(5.0),
                decoration: pw.BoxDecoration(
                    color: color2
                ),
                child: PdfTextWidget(
                  text: text2 ?? "error",
                  textAlign: textAlign2,
                  color:text2 !=null ? text2Color : redColor,
                  size: textSize!,
                  isBold: isText2,
                ),
            ),




          ]
        )
        ]
    );
  }
}
