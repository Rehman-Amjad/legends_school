import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfCardBackWidget extends pw.StatelessWidget {
  final String id;
  final PdfColor boxColor;
  var facebookImage,whatsappImage,webImage,playStoreImage,emailImage;

  PdfCardBackWidget({
    required this.id,
    this.boxColor = PdfColors.white,
    required this.facebookImage,
    required this.whatsappImage,
    required this.webImage,
    required this.playStoreImage,
    required this.emailImage,
  });

  var rowMargin = 2.0;
  var tableTextMargin = 5.0;
  var sideTextSize = 12.0;
  var sideWidthSize = 15.0;
  var pdfCardHeight = 215.0;
  var pdfInnerCardHeight = 200.0;
  var pdfCardWidth = 128.0;

  var academyAddress = "FSD";
  var academyWeb = "@legendschool";
  var academyWhatsapp = "+92 123 456789";
  var academyFacebook = "@legendschool";
  var academyEmail = "legendschool@gmail.com";
  var academyTitle = "Legends";
  var academySubTitle = "School System";
  var academySession = "2024-25";

  String amberColor = "#FFBF00",
      blackColor = "#000000",
      darkBlue = "00008B",
      whiteColor = "#FFFFFF",
      redColor = "#02CCFE",
      lightBlue = "#02CCFE",
      yellowColor = "#FFFF00",
      greenColor = "#00FF00";

  @override
  pw.Widget build(pw.Context context) {
    return  pw.Container(
      margin: pw.EdgeInsets.only(left: 5),
      color: PdfColor.fromHex(lightBlue),
      child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                    width: sideWidthSize,
                    height: pdfCardHeight,
                    alignment: pw.Alignment.center,
                    color: PdfColor.fromHex(lightBlue),
                    margin: pw.EdgeInsets.only(
                        left: 2, top: 2, bottom: 2),
                    child: pw.Column(
                      mainAxisAlignment:
                      pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.Text(
                          "S",
                          style: pw.TextStyle(
                              fontSize: sideTextSize,
                              fontWeight: pw.FontWeight.bold,
                              color:
                              PdfColor.fromHex(yellowColor)),
                        ),
                        pw.Text(
                          "T",
                          style: pw.TextStyle(
                              fontSize: sideTextSize,
                              fontWeight: pw.FontWeight.bold,
                              color:
                              PdfColor.fromHex(yellowColor)),
                        ),
                        pw.Text(
                          "U",
                          style: pw.TextStyle(
                              fontSize: sideTextSize,
                              fontWeight: pw.FontWeight.bold,
                              color:
                              PdfColor.fromHex(yellowColor)),
                        ),
                        pw.Text(
                          "D",
                          style: pw.TextStyle(
                              fontSize: sideTextSize,
                              fontWeight: pw.FontWeight.bold,
                              color:
                              PdfColor.fromHex(yellowColor)),
                        ),
                        pw.Text(
                          "E",
                          style: pw.TextStyle(
                              fontSize: sideTextSize,
                              fontWeight: pw.FontWeight.bold,
                              color:
                              PdfColor.fromHex(yellowColor)),
                        ),
                        pw.Text(
                          "N",
                          style: pw.TextStyle(
                              fontSize: sideTextSize,
                              fontWeight: pw.FontWeight.bold,
                              color:
                              PdfColor.fromHex(yellowColor)),
                        ),
                        pw.Text(
                          "T",
                          style: pw.TextStyle(
                              fontSize: sideTextSize,
                              fontWeight: pw.FontWeight.bold,
                              color:
                              PdfColor.fromHex(yellowColor)),
                        ),
                      ],
                    )),
                pw.Container(
                  width: pdfCardWidth,
                  margin: pw.EdgeInsets.only(
                      left: 2, top: 2, right: 2),
                  child: pw.Column(children: [
                    pw.Container(
                      width: pdfCardWidth,
                      color: PdfColor.fromHex(redColor),
                      child: pw.Column(children: [
                        pw.Text(
                          "$academyTitle",
                          style: pw.TextStyle(
                              fontSize: 14,
                              color: PdfColor.fromHex(amberColor),
                              fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Text(
                          "$academySubTitle",
                          style: pw.TextStyle(
                              fontSize: 8,
                              color: PdfColor.fromHex(amberColor),
                              fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(
                          height: 5,
                        )
                      ]),
                    ),
                    pw.Container(
                      width: pdfCardWidth,
                      color: PdfColor.fromHex(whiteColor),
                      child: pw.Column(children: [
                        pw.Container(
                          width: 80,
                          height: 80,
                          padding: pw.EdgeInsets.all(10.0),
                          child: pw.BarcodeWidget(
                            color: PdfColor.fromHex("#000000"),
                            barcode: pw.Barcode.qrCode(),
                            data:
                            id.toString(),
                          ),
                        ),
                        pw.SizedBox(
                          height: 5,
                        )
                      ]),
                    ),
                    pw.Container(
                      width: pdfCardWidth,
                      color: PdfColor.fromHex(whiteColor),
                      child: pw.Column(children: [
                        pw.Container(
                          padding: pw.EdgeInsets.all(5.0),
                          child: pw.Table(
                            columnWidths: {
                              0: pw.FlexColumnWidth(2),
                              1: pw.FlexColumnWidth(4),
                            },
                            children: [
                              pw.TableRow(children: [
                                pw.Container(
                                    height: 10,
                                    width: 10,
                                    child:
                                    pw.Image(facebookImage)),
                                pw.Container(
                                  child: pw.Text(
                                    "$academyFacebook",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor)),
                                  ),
                                )
                              ]),
                              pw.TableRow(children: [
                                pw.Container(
                                    height: 10,
                                    width: 10,
                                    margin: pw.EdgeInsets.only(
                                        top: 3),
                                    child: pw.Image(emailImage)),
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "$academyEmail",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor)),
                                  ),
                                )
                              ]),
                              pw.TableRow(children: [
                                pw.Container(
                                    height: 10,
                                    width: 10,
                                    margin: pw.EdgeInsets.only(
                                        top: 3),
                                    child:
                                    pw.Image(whatsappImage)),
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "$academyWhatsapp",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor)),
                                  ),
                                )
                              ]),
                              pw.TableRow(children: [
                                pw.Container(
                                    height: 10,
                                    width: 10,
                                    margin: pw.EdgeInsets.only(
                                        top: 3),
                                    child: pw.Image(playStoreImage)),
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "$academyWeb",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor)),
                                  ),
                                )
                              ]),
                              pw.TableRow(children: [
                                pw.Container(
                                    height: 10,
                                    width: 10,
                                    margin: pw.EdgeInsets.only(
                                        top: 3),
                                    child: pw.Image(webImage)),
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "$academyAddress",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor)),
                                  ),
                                )
                              ]),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ),
                pw.SizedBox(width: 3),
              ],
            )
          ]),
    );
  }
}