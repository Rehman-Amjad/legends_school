import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../components/table6Column.dart';
class StudentTablePWidget extends pw.StatelessWidget {

  final String subject1,subject2,subject3,subject4,subject5,subject6,subject7,subject8,subject9,
  subjectPrice1,subjectPrice2,subjectPrice3,subjectPrice4,subjectPrice5,subjectPrice6,subjectPrice7,
  subjectPrice8,subjectPrice9;
  StudentTablePWidget( {
   required this.subject1,
    required this.subject2,
    required this.subject3,
    required this.subject4,
    required this.subject5,
    required this.subject6,
    required this.subject7,
    required this.subject8,
    required this.subject9,
    required this.subjectPrice1,
    required this.subjectPrice2,
    required this.subjectPrice3,
    required this.subjectPrice4,
    required this.subjectPrice5,
    required this.subjectPrice6,
    required this.subjectPrice7,
    required this.subjectPrice8,
    required this.subjectPrice9,
});
  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        children: [

          Table6columnPdf(
            text1: "SR".toUpperCase(),
            flex1: 1,
            color1: PdfColors.amber,

            text2: "SUBJECT".toString().toUpperCase(),
            color2: PdfColors.amber,

            text3: "FEE".toUpperCase(),
            color3: PdfColors.amber,

            text4: "SR".toUpperCase(),
            color4: PdfColors.amber,

            text5: "SUBJECT".toString().toUpperCase(),
            color5: PdfColors.amber,

            text6: "FEE".toUpperCase(),
            color6: PdfColors.amber,
          ),

          // 1
          Table6columnPdf(
            text1: "1".toUpperCase(),
            flex1: 1,
            isText1: false,

            text2: subject1.toString().toUpperCase(),
            isText2: false,

            text3: subjectPrice1.toUpperCase(),
            isText3: false,

            text4: "2".toUpperCase(),
            isText4: false,

            text5: subject2.toString().toUpperCase(),
            isText5: false,

            text6: subjectPrice2.toUpperCase(),
            isText6: false,
          ),

          // 2
          Table6columnPdf(
            text1: "3".toUpperCase(),
            flex1: 1,
            isText1: false,

            text2: subject3.toString().toUpperCase(),
            isText2: false,

            text3: subjectPrice3.toUpperCase(),
            isText3: false,

            text4: "4".toUpperCase(),
            isText4: false,

            text5: subject4.toString().toUpperCase(),
            isText5: false,

            text6: subjectPrice4.toUpperCase(),
            isText6: false,
          ),

          // 3
          Table6columnPdf(
            text1: "5".toUpperCase(),
            flex1: 1,
            isText1: false,

            text2: subject5.toString().toUpperCase(),
            isText2: false,

            text3: subjectPrice5.toUpperCase(),
            isText3: false,

            text4: "6".toUpperCase(),
            isText4: false,

            text5: subject6.toString().toUpperCase(),
            isText5: false,

            text6: subjectPrice6.toUpperCase(),
            isText6: false,
          ),

          // 4
          Table6columnPdf(
            text1: "7".toUpperCase(),
            flex1: 1,
            isText1: false,

            text2: subject7.toString().toUpperCase(),
            isText2: false,

            text3: subjectPrice7.toUpperCase(),
            isText3: false,

            text4: "8".toUpperCase(),
            isText4: false,

            text5: subject8.toString().toUpperCase(),
            isText5: false,

            text6: subjectPrice8.toUpperCase(),
            isText6: false,
          ),

          // 53
          Table6columnPdf(
            text1: "9".toUpperCase(),
            flex1: 1,
            isText1: false,

            text2: subject9.toString().toUpperCase(),
            isText2: false,

            text3: subjectPrice9.toUpperCase(),
            isText3: false,

            text4: "".toUpperCase(),
            isText4: false,

            text5: "".toString().toUpperCase(),
            isText5: false,

            text6: "".toUpperCase(),
            isText6: false,
          ),




        ]
    );
  }
}
