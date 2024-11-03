import 'package:pdf/widgets.dart' as pw;

class SignaturePdf extends pw.StatelessWidget {

  @override
  pw.Widget build(pw.Context context) {
    return pw.Table(
        columnWidths: const{
          0: pw.FlexColumnWidth(4),
          1: pw.FlexColumnWidth(4),
        },
        children: [
          pw.TableRow(
              children: [
                pw.Container(
                  margin: const pw.EdgeInsets.only(left: 2.0,top: 2.0,bottom: 2.0,right: 5.0),
                  child: pw.Text("Student's Signature__________________"),
                ),
                pw.Container(
                  margin: const pw.EdgeInsets.only(left: 5.0,top: 2.0,bottom: 2.0,right: 2.0),
                  child: pw.Text("Parent's Signature____________________"),
                )
              ]
          )
        ]
    );
  }
}



