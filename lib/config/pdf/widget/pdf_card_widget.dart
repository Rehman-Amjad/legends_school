import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfCardFrontWidget extends pw.StatelessWidget {
  final String id,name,fatherName,dob,registrationNo,className,group,gender;
  final PdfColor boxColor;
  var imageUrl,image;

  PdfCardFrontWidget({
    required this.id,
    required this.name,
    required this.fatherName,
    required this.dob,
    required this.registrationNo,
    required this.className,
    required this.group,
    required this.gender,
     this.boxColor = PdfColors.white,
   required this.imageUrl,
   required this.image
  });

  var rowMargin = 2.0;
  var tableTextMargin = 5.0;
  var sideTextSize = 12.0;
  var sideWidthSize = 15.0;
  var pdfCardHeight = 215.0;
  var pdfInnerCardHeight = 200.0;
  var pdfCardWidth = 128.0;

  var academyAddress = "Ali Housing Colony";
  var academyWeb = "@aleezayacademy";
  var academyWhatsapp = "+92 301 2650333";
  var academyFacebook = "@aleezayacademy";
  var academyEmail = "aleezayacademy@gmail.com";
  var academyTitle = "Aleezay";
  var academySubTitle = "Group of Academies";
  var academySession = "2024-25";

  String amberColor = "#FFBF00",
      blackColor = "#000000",
      darkBlue = "00008B",
      whiteColor = "#FFFFFF",
      redColor = "#FF0000",
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
                        pw.Table(
                          columnWidths: {
                            0: pw.FlexColumnWidth(3),
                            1: pw.FlexColumnWidth(3),
                          },
                          children: [
                            pw.TableRow(children: [
                              pw.Container(
                                width: 40,
                                height: 40,
                                padding: pw.EdgeInsets.all(5.0),
                                child: pw.Image(imageUrl),
                              ),
                              pw.Container(
                                width: 30,
                                height: 30,
                                margin:
                                pw.EdgeInsets.only(top: 3),
                                child: pw.Image(image),
                              )
                            ]),
                            pw.TableRow(children: [
                              pw.Container(
                                width: 30,
                                child: pw.Text(""),
                              ),
                              pw.Container(
                                width: 30,
                                margin:
                                pw.EdgeInsets.only(top: 3),
                                child: pw.Text(
                                  "ID: $id",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight:
                                      pw.FontWeight.bold,
                                      color: PdfColor.fromHex(
                                          redColor)),
                                ),
                              )
                            ])
                          ],
                        ),
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
                                  child: pw.Text(
                                    "Name",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor),
                                        fontWeight:
                                        pw.FontWeight.bold),
                                  ),
                                ),
                                pw.Container(
                                  child: pw.Text(
                                    "$name",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor)),
                                  ),
                                )
                              ]),
                              pw.TableRow(children: [
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "F.Name",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor),
                                        fontWeight:
                                        pw.FontWeight.bold),
                                  ),
                                ),
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "$fatherName",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor)),
                                  ),
                                )
                              ]),
                              pw.TableRow(children: [
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "D.O.B",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor),
                                        fontWeight:
                                        pw.FontWeight.bold),
                                  ),
                                ),
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "$dob",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor)),
                                  ),
                                )
                              ]),
                              pw.TableRow(children: [
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "Reg No",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor),
                                        fontWeight:
                                        pw.FontWeight.bold),
                                  ),
                                ),
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "$registrationNo",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor)),
                                  ),
                                )
                              ]),
                              pw.TableRow(children: [
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "Class",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor),
                                        fontWeight:
                                        pw.FontWeight.bold),
                                  ),
                                ),
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "$className",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor)),
                                  ),
                                )
                              ]),
                              pw.TableRow(children: [
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "Group",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor),
                                        fontWeight:
                                        pw.FontWeight.bold),
                                  ),
                                ),
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "$group",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor)),
                                  ),
                                )
                              ]),
                              pw.TableRow(children: [
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "session",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor),
                                        fontWeight:
                                        pw.FontWeight.bold),
                                  ),
                                ),
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "$academySession",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor)),
                                  ),
                                )
                              ]),
                              pw.TableRow(children: [
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "Gender",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        color: PdfColor.fromHex(
                                            blackColor),
                                        fontWeight:
                                        pw.FontWeight.bold),
                                  ),
                                ),
                                pw.Container(
                                  margin:
                                  pw.EdgeInsets.only(top: 3),
                                  child: pw.Text(
                                    "$gender",
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