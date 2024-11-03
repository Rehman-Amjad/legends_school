import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;

class TeacherCardScreen extends StatefulWidget {
  const TeacherCardScreen({Key? key}) : super(key: key);

  @override
  _TeacherCardScreenState createState() => _TeacherCardScreenState();
}

class _TeacherCardScreenState extends State<TeacherCardScreen> {
  String teacherCNIC1 = "",
      teacherCNIC2 = "",
      teacherCNIC3 = "",
      teacherCNIC4 = "";
  var teacherCNICController1 = new TextEditingController();
  var teacherCNICController2 = new TextEditingController();
  var teacherCNICController3 = new TextEditingController();
  var teacherCNICController4 = new TextEditingController();

  final pdf = pw.Document();
  var pdfFileName = "";
  String amberColor = "#FFBF00",
      blackColor = "#000000",
      darkBlue = "00008B",
      whiteColor = "#FFFFFF",
      redColor = "#FF0000",
      lightBlue = "#02CCFE",
      yellowColor = "#FFFF00",
      greenColor = "#00FF00",
      darkGreenColor = "#32CD32";

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

  String techerName1 = "",
      tacherFatherName1 = "",
      teacherCNICNumber1 = "",
      teacherSubject1 = "",
      teacherGroup1 = "",
      teacherSession1 = "",
      teacherJob1 = "",
      teacherGender1 = "",
      teacherImage1 = "";
  String techerName2 = "",
      tacherFatherName2 = "",
      teacherCNICNumber2 = "",
      teacherSubject2 = "",
      teacherGroup2 = "",
      teacherJob2 = "",
      teacherSession2 = "",
      teacherGender2 = "",
      teacherImage2 = "";
  String techerName3 = "",
      tacherFatherName3 = "",
      teacherCNICNumber3 = "",
      teacherSubject3 = "",
      teacherGroup3 = "",
      teacherSession3 = "",
      teacherJob3 = "",
      teacherGender3 = "",
      teacherImage3 = "";
  String techerName4 = "",
      tacherFatherName4 = "",
      teacherCNICNumber4 = "",
      teacherSubject4 = "",
      teacherGroup4 = "",
      teacherJob4 = "",
      teacherSession4 = "",
      teacherGender4 = "",
      teacherImage4 = "";

  final collectRef =
      FirebaseFirestore.instance.collection("teacherRegistrations");
  var taskText = "Search Taecher and Generate Cards";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher Card Search / Generate"),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: AlignmentDirectional.center,
                height: 150,
                child: Image.asset("assets/images/aleezay.webp"),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                child: Text(
                  taskText,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      controller: teacherCNICController1,
                      decoration: InputDecoration(
                          labelText: "Teacher CNIC",
                          hintText: "Enter Teacher CNIC",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      controller: teacherCNICController2,
                      decoration: InputDecoration(
                          labelText: "Teacher CNIC",
                          hintText: "Enter Teacher CNIC",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                ],
              ),

              //==================================================================================
              //==================================================================================
              //second line edit field
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      controller: teacherCNICController3,
                      decoration: InputDecoration(
                          labelText: "Teacher CNIC",
                          hintText: "Enter Teacher CNIC",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      controller: teacherCNICController4,
                      decoration: InputDecoration(
                          labelText: "Teacher CNIC",
                          hintText: "Enter Teacher CNIC",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 150,
                    height: 60,
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        teacherCNIC1 = teacherCNICController1.text.toString();
                        teacherCNIC2 = teacherCNICController2.text.toString();
                        teacherCNIC3 = teacherCNICController3.text.toString();
                        teacherCNIC4 = teacherCNICController4.text.toString();

                        getTeacherDetails(teacherCNIC1, teacherCNIC2,
                            teacherCNIC3, teacherCNIC4);
                      },
                      child: Text("Generate Card"),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  void getTeacherDetails(String teacherCNIC1, String teacherCNIC2,
      String teacherCNIC3, String teacherCNIC4) async {
    setState(() {
      taskText = "Fetching Student 1 records please wait a moment";
    });
    var documentSnapshot = await collectRef.doc("$teacherCNIC1").get();
    if (documentSnapshot.exists) {
      Map<String, dynamic>? data = documentSnapshot.data();
      techerName1 = data?['teacherName'];
      tacherFatherName1 = data?['teacherFatherName'];
      teacherCNICNumber1 = data?['teacherCNIC'];
      teacherSubject1 = data?['techerSubject'];
      teacherGroup1 = data?['teacherGroup'];
      teacherSession1 = data?['teacherClass'];
      teacherGender1 = data?['gender'];
      teacherImage1 = data?['teacherImage'];
      teacherJob1 = data?['jobTitle'];

      getTeacher2Records(teacherCNIC2, teacherCNIC3, teacherCNIC4);
    }
  }

  void getTeacher2Records(
      String teacherCNIC2, String teacherCNIC3, String teacherCNIC4) async {
    setState(() {
      taskText = "Fetching Student 2 records please wait a moment";
    });
    var documentSnapshot = await collectRef.doc("$teacherCNIC2").get();
    if (documentSnapshot.exists) {
      Map<String, dynamic>? data = documentSnapshot.data();
      techerName2 = data?['teacherName'];
      tacherFatherName2 = data?['teacherFatherName'];
      teacherCNICNumber2 = data?['teacherCNIC'];
      teacherSubject2 = data?['techerSubject'];
      teacherGroup2 = data?['teacherGroup'];
      teacherSession2 = data?['teacherClass'];
      teacherGender2 = data?['gender'];
      teacherImage2 = data?['teacherImage'];
      teacherJob2 = data?['jobTitle'];

      getTeacher3Records(teacherCNIC3, teacherCNIC4);
    }
  }

  void getTeacher3Records(String teacherCNIC3, String teacherCNIC4) async {
    setState(() {
      taskText = "Fetching Student 3 records please wait a moment";
    });
    var documentSnapshot = await collectRef.doc("$teacherCNIC3").get();
    if (documentSnapshot.exists) {
      Map<String, dynamic>? data = documentSnapshot.data();
      techerName3 = data?['teacherName'];
      tacherFatherName3 = data?['teacherFatherName'];
      teacherCNICNumber3 = data?['teacherCNIC'];
      teacherSubject3 = data?['techerSubject'];
      teacherGroup3 = data?['teacherGroup'];
      teacherSession3 = data?['teacherClass'];
      teacherGender3 = data?['gender'];
      teacherImage3 = data?['teacherImage'];
      teacherJob3 = data?['jobTitle'];

      getTeacher4Records(teacherCNIC4);
    }
  }

  void getTeacher4Records(String teacherCNIC4) async {
    setState(() {
      taskText = "Fetching Student 4 records please wait a moment";
    });
    var documentSnapshot = await collectRef.doc("$teacherCNIC4").get();
    if (documentSnapshot.exists) {
      Map<String, dynamic>? data = documentSnapshot.data();
      techerName4 = data?['teacherName'];
      tacherFatherName4 = data?['teacherFatherName'];
      teacherCNICNumber4 = data?['teacherCNIC'];
      teacherSubject4 = data?['techerSubject'];
      teacherGroup4 = data?['teacherGroup'];
      teacherSession4 = data?['teacherClass'];
      teacherGender4 = data?['gender'];
      teacherImage4 = data?['teacherImage'];
      teacherJob4 = data?['jobTitle'];

      setState(() {
        taskText = "all student data found now generating pdf file please wait";
        // taskText = student1Image;
      });
      generatePDF(context);
    }
  }

  Future<void> generatePDF(BuildContext context) async {
    // Create a PDF document

    var today = DateTime.now();
    var dateFormat = DateFormat('dd-MM-yyyy');
    String currentTime = DateFormat("hh:mm:ss a").format(DateTime.now());
    String currentDate = dateFormat.format(today);
    pdfFileName = "${currentDate.toString()} ${currentTime.toString()}.pdf";
    print(pdfFileName);

    final response = await http.get(Uri.parse(teacherImage1));
    final imageURL1 = pw.MemoryImage(response.bodyBytes);

    final response2 = await http.get(Uri.parse(teacherImage2));
    final imageURL2 = pw.MemoryImage(response2.bodyBytes);

    final response3 = await http.get(Uri.parse(teacherImage3));
    final imageURL3 = pw.MemoryImage(response3.bodyBytes);

    final response4 = await http.get(Uri.parse(teacherImage4));
    final imageURL4 = pw.MemoryImage(response4.bodyBytes);

    final imageBytes = await rootBundle.load('assets/images/aleezay.webp');
    final image = pw.MemoryImage(imageBytes.buffer.asUint8List());

    final facebookBytes = await rootBundle.load('assets/images/facebook.png');
    final facebookImage = pw.MemoryImage(facebookBytes.buffer.asUint8List());

    final whatsappBytes = await rootBundle.load('assets/images/whatsapp.png');
    final whatsappImage = pw.MemoryImage(whatsappBytes.buffer.asUint8List());

    final emailBytes = await rootBundle.load('assets/images/gmail.png');
    final emailImage = pw.MemoryImage(emailBytes.buffer.asUint8List());

    final webBytes = await rootBundle.load('assets/images/location.png');
    final webImage = pw.MemoryImage(webBytes.buffer.asUint8List());

    final playBytes = await rootBundle.load('assets/images/game.png');
    final playImage = pw.MemoryImage(playBytes.buffer.asUint8List());

    // Add content to the PDF document
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(height: 10),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  //====================================================================================
                  //====================================================================================
                  //====================================================================================
                  // First Card
                  pw.Container(
                    margin: pw.EdgeInsets.only(left: 5),
                    color: PdfColor.fromHex(darkGreenColor),
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
                                  color: PdfColor.fromHex(darkGreenColor),
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
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "T",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "A",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
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
                                              width: 30,
                                              height: 30,
                                              margin:
                                              pw.EdgeInsets.only(top: 3),
                                              child: pw.Image(imageURL1),
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
                                              width: 400,
                                              margin:
                                              pw.EdgeInsets.only(top: 3),
                                              child: pw.Text(
                                                "Job Title \n $teacherJob1",
                                                style: pw.TextStyle(
                                                    fontSize: 6,
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
                                            0: pw.FlexColumnWidth(3),
                                            1: pw.FlexColumnWidth(4),
                                          },
                                          children: [
                                            pw.TableRow(children: [
                                              pw.Container(
                                                child: pw.Text(
                                                  "Name:",
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
                                                  "$techerName1",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "F.Name:",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$tacherFatherName1",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "CNIC:",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherCNIC1",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "Subject",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherSubject1",
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
                                                    pw.EdgeInsets.only(top: 5),
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherGroup1",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "Session",
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
                                                    pw.EdgeInsets.only(top: 5),
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
                                                    pw.EdgeInsets.only(top: 5),
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherGender1",
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
                  ),

                  //=====================================================================================
                  //=====================================================================================
                  //=====================================================================================
                  //=====================================================================================
                  // Second card
                  pw.SizedBox(width: 10),

                  pw.Container(
                    margin: pw.EdgeInsets.only(left: 5),
                    color: PdfColor.fromHex(darkGreenColor),
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
                                  color: PdfColor.fromHex(darkGreenColor),
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
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "T",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "A",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
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
                                              width: 30,
                                              height: 30,
                                              margin:
                                              pw.EdgeInsets.only(top: 3),
                                              child: pw.Image(imageURL2),
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
                                              width: 400,
                                              margin:
                                              pw.EdgeInsets.only(top: 3),
                                              child: pw.Text(
                                                "Job Title \n $teacherJob2",
                                                style: pw.TextStyle(
                                                    fontSize: 6,
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
                                            0: pw.FlexColumnWidth(3),
                                            1: pw.FlexColumnWidth(4),
                                          },
                                          children: [
                                            pw.TableRow(children: [
                                              pw.Container(
                                                child: pw.Text(
                                                  "Name:",
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
                                                  "$techerName2",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "F.Name:",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$tacherFatherName2",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "CNIC:",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherCNIC2",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "Subject",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherSubject2",
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
                                                    pw.EdgeInsets.only(top: 5),
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherGroup2",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "Session",
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
                                                    pw.EdgeInsets.only(top: 5),
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
                                                    pw.EdgeInsets.only(top: 5),
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherGender2",
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
                  ),

                  //=====================================================================================
                  //=====================================================================================
                  //=====================================================================================
                  //=====================================================================================
                  // Third Card

                  pw.SizedBox(width: 10),

                  pw.Container(
                    margin: pw.EdgeInsets.only(left: 5),
                    color: PdfColor.fromHex(darkGreenColor),
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
                                  color: PdfColor.fromHex(darkGreenColor),
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
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "T",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "A",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
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
                                              width: 30,
                                              height: 30,
                                              margin:
                                              pw.EdgeInsets.only(top: 3),
                                              child: pw.Image(imageURL3),
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
                                              width: 400,
                                              margin:
                                              pw.EdgeInsets.only(top: 3),
                                              child: pw.Text(
                                                "Job Title \n $teacherJob3",
                                                style: pw.TextStyle(
                                                    fontSize: 6,
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
                                            0: pw.FlexColumnWidth(3),
                                            1: pw.FlexColumnWidth(4),
                                          },
                                          children: [
                                            pw.TableRow(children: [
                                              pw.Container(
                                                child: pw.Text(
                                                  "Name:",
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
                                                  "$techerName3",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "F.Name:",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$tacherFatherName3",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "CNIC:",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherCNIC3",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "Subject",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherSubject3",
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
                                                    pw.EdgeInsets.only(top: 5),
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherGroup3",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "Session",
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
                                                    pw.EdgeInsets.only(top: 5),
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
                                                    pw.EdgeInsets.only(top: 5),
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherGender3",
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
                  ),

                  //======================================================================================

                  //=====================================================================================
                  //=====================================================================================
                  //=====================================================================================
                  //=====================================================================================
                  // Fourth Card

                  pw.SizedBox(width: 10),

                  pw.Container(
                    margin: pw.EdgeInsets.only(left: 5),
                    color: PdfColor.fromHex(darkGreenColor),
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
                                  color: PdfColor.fromHex(darkGreenColor),
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
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "T",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "A",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
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
                                              width: 30,
                                              height: 30,
                                              margin:
                                              pw.EdgeInsets.only(top: 3),
                                              child: pw.Image(imageURL4),
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
                                              width: 400,
                                              margin:
                                              pw.EdgeInsets.only(top: 3),
                                              child: pw.Text(
                                                "Job Title \n $teacherJob4",
                                                style: pw.TextStyle(
                                                    fontSize: 6,
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
                                            0: pw.FlexColumnWidth(3),
                                            1: pw.FlexColumnWidth(4),
                                          },
                                          children: [
                                            pw.TableRow(children: [
                                              pw.Container(
                                                child: pw.Text(
                                                  "Name:",
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
                                                  "$techerName4",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "F.Name:",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$tacherFatherName4",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "CNIC:",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherCNIC4",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "Subject",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherSubject4",
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
                                                    pw.EdgeInsets.only(top: 5),
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherGroup4",
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "Session",
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
                                                    pw.EdgeInsets.only(top: 5),
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
                                                    pw.EdgeInsets.only(top: 5),
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
                                                    pw.EdgeInsets.only(top: 5),
                                                child: pw.Text(
                                                  "$teacherGender4",
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
                  ),
                  //======================================================================================
                ],
              ),

              //===========================================================================================
              //===========================================================================================
              //===========================================================================================
              //===========================================================================================
              //Second Line Card Starting

              pw.SizedBox(height: 20),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  //=======================================================================================
                  //=======================================================================================
                  //=======================================================================================
                  //2nd card 1

                  pw.Container(
                    margin: pw.EdgeInsets.only(left: 5),
                    color: PdfColor.fromHex(darkGreenColor),
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
                                  color: PdfColor.fromHex(darkGreenColor),
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
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "T",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "A",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
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
                                          data: "$teacherCNIC1",
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
                                            0: pw.FlexColumnWidth(1),
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
                                                  child: pw.Image(playImage)),
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
                  ),

                  //===============================================================================================
                  //===============================================================================================
                  //===============================================================================================
                  //===============================================================================================
                  //2nd card 2
                  pw.SizedBox(width: 10),

                  pw.Container(
                    margin: pw.EdgeInsets.only(left: 5),
                    color: PdfColor.fromHex(darkGreenColor),
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
                                  color: PdfColor.fromHex(darkGreenColor),
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
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "T",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "A",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
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
                                          data: "$teacherCNIC2",
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
                                            0: pw.FlexColumnWidth(1),
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
                                                  child: pw.Image(playImage)),
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
                  ),
                  //=======================================================================================================
                  //=======================================================================================================
                  //=======================================================================================================
                  //=======================================================================================================
                  //2nd card 3
                  pw.SizedBox(width: 10),

                  pw.Container(
                    margin: pw.EdgeInsets.only(left: 5),
                    color: PdfColor.fromHex(darkGreenColor),
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
                                  color: PdfColor.fromHex(darkGreenColor),
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
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "T",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "A",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
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
                                          data: "$teacherCNIC3",
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
                                            0: pw.FlexColumnWidth(1),
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
                                                  child: pw.Image(playImage)),
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
                  ),

                  //=====================================================================================================
                  //=====================================================================================================
                  //=====================================================================================================
                  //=====================================================================================================
                  //2nd card 4
                  pw.SizedBox(width: 10),

                  pw.Container(
                    margin: pw.EdgeInsets.only(left: 5),
                    color: PdfColor.fromHex(darkGreenColor),
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
                                  color: PdfColor.fromHex(darkGreenColor),
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
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "T",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "A",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
                                      ),
                                      pw.Text(
                                        "F",
                                        style: pw.TextStyle(
                                            fontSize: sideTextSize,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColor.fromHex(redColor)),
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
                                          data: "$teacherCNIC4",
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
                                            0: pw.FlexColumnWidth(1),
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
                                                  child: pw.Image(playImage)),
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
                  ),

                  //======================================================================
                ],
              )
            ],
          ); // Center
        }));

    // Save the PDF document to a file
    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = pdfFileName;
    html.document.body!.children.add(anchor);
    anchor.click();
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
