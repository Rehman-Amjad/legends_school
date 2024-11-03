import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ParentAccountDetaillsPdf extends pw.StatelessWidget {

  final  formID,fatherCNIC;

  ParentAccountDetaillsPdf({
    required this.formID,
    required this.fatherCNIC,
  });
  @override
  pw.Widget build(pw.Context context) {
    return pw.Table(
        columnWidths: const {
          0: pw.FlexColumnWidth(4),
          1: pw.FlexColumnWidth(4),
          2: pw.FlexColumnWidth(4),
          3: pw.FlexColumnWidth(4),
        },
        border: pw.TableBorder.all(color: PdfColors.black,width: 0.5),
        children: [
          pw.TableRow(
              children: [
                pw.Container(
                  width: 80,
                  height: 80,
                  padding: const pw.EdgeInsets.all(10.0),
                  child: pw.BarcodeWidget(
                    color: PdfColor.fromHex("#000000"),
                    barcode: pw.Barcode.qrCode(),
                    data: formID ?? "error",
                  ),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(5.0),
                  child: pw.Text(fatherCNIC ?? "error"),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(5.0),
                  child: pw.Text("12345"),
                ),
                pw.Container(
                  width: 80,
                  height: 80,
                  padding: const pw.EdgeInsets.all(10.0),
                  child: pw.BarcodeWidget(
                    color: PdfColor.fromHex("#000000"),
                    barcode: pw.Barcode.qrCode(),
                    data: "https://play.google.com/store/apps/details?id=com.rehman.aleezayacademy",
                  ),
                )
              ]
          )
        ]
    );
  }
}



