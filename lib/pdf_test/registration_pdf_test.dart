import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationPDFTest extends StatefulWidget {
  const RegistrationPDFTest({Key? key}) : super(key: key);

  @override
  State<RegistrationPDFTest> createState() => _RegistrationPDFTestState();
}

class _RegistrationPDFTestState extends State<RegistrationPDFTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Download"),
          onPressed: (){
            generatePDF(context);
          },
        ),
      ),
    );
  }

  Future<void> generatePDF(BuildContext context) async {
    // Create a PDF document
    final pdf = pw.Document();
    var pdfFileName = "";
    String amberColor = "#FFBF00",blackColor = "#000000",darkBlue = "#FFA500",whiteColor = "#FFFFFF";

    // var imageUrl = 'https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg';
    // var response = await get(Uri.parse(imageUrl));
    // var data = response.bodyBytes;


    // work properly with jpg image extenstion
    // String? imagepath = "https://firebasestorage.googleapis.com/v0/b/legends-school.appspot.com/o/StudentAdmissionFormImage%2F2023-11-23%2022%3A32%3A05.698?alt=media&token=7ae23ea9-6ee5-4761-ada3-24e0f07d63be";
    final response = await http.get(Uri.parse("https://ik.imagekit.io/ikmedia/backlit.jpg"));
    final imageURL = pw.MemoryImage(response.bodyBytes);





    // final ref = FirebaseStorage.instance.ref().child('image_1683791555842.jpg');
    // final imageData = await ref.getData();
    // final imageURL = pw.MemoryImage(imageData!);


    var today = DateTime.now();
    var dateFormat = DateFormat('dd-MM-yyyy');
    String currentTime = DateFormat("hh:mm:ss a").format(DateTime.now());
    String currentDate = dateFormat.format(today);
    pdfFileName = "${"formID".toString()}_${currentDate.toString()}.pdf";
    print(pdfFileName);

    final  imageBytes = await rootBundle.load('assets/images/admin.png');
    final image = pw.MemoryImage(imageBytes.buffer.asUint8List());
    // Add content to the PDF document

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                  children: [
                    pw.Container(
                      width: 100,
                      child: pw.Image(image),
                      // child: pw.Text("imageURL"),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Container(
                              width: 300,
                              alignment: pw.Alignment.center,
                              child: pw.Text("Legends School and College",style: pw.TextStyle(
                                color: PdfColor.fromHex("#00008B"),
                                fontSize: 21,
                                fontWeight: pw.FontWeight.bold,
                              ))
                          ),
                          pw.Container(
                              width: 300,
                              padding: pw.EdgeInsets.all(4.0),
                              alignment: pw.Alignment.center,
                              child: pw.Text("Your Preparation is our Responsibility",style: pw.TextStyle(
                                color: PdfColor.fromHex("#00008B"),
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              ))
                          ),
                          pw.Container(
                              width: 300,
                              padding: pw.EdgeInsets.all(2.0),
                              alignment: pw.Alignment.center,
                              child: pw.Text("Email: legendsschools56@gmail.com",style: pw.TextStyle(
                                color: PdfColor.fromHex("#FF0000"),
                              ))
                          ),
                          pw.Container(
                              width: 300,
                              padding: pw.EdgeInsets.all(2.0),
                              alignment: pw.Alignment.center,
                              child: pw.Text("Whatsapp & Mobile: 03221220797")
                          ),
                          pw.Container(
                              width: 300,
                              padding: pw.EdgeInsets.all(2.0),
                              alignment: pw.Alignment.center,
                              child: pw.Text("Phone: 03221220797")
                          ),
                          pw.SizedBox(height: 20),

                        ]
                    ),
                    pw.SizedBox(width: 20),

                    pw.Container(
                        width: 80,
                        height: 80,
                        padding: pw.EdgeInsets.all(10.0),
                        child: pw.Image(imageURL)
                        // child: pw.Image(imageURL)
                    )
                  ]
              ),
              pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Text("APPLICATION FOR REGISTRATION",style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ))
              ),
              pw.Container(
                  padding: pw.EdgeInsets.all(5.0),
                  alignment: pw.Alignment.center,
                  child: pw.Text("Please complete each section of BLOCK LETTER using black ink",style: pw.TextStyle(
                    fontSize: 11,
                  ))
              ),
              pw.SizedBox(height: 10),

              pw.Table.fromTextArray(
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#FFBF00"),
                  ),
                  columnWidths: {
                    0: pw.FlexColumnWidth(4),
                    1: pw.FlexColumnWidth(4),
                    2: pw.FlexColumnWidth(4),
                  },
                  context: context,
                  headerStyle: pw.TextStyle(fontSize: 11,fontWeight: pw.FontWeight.bold),
                  cellStyle: pw.TextStyle(fontSize: 10),
                  data: <List<String>>[
                    <String>['FORM ID', 'REGISTRATION NUMBER', 'COACHING STATUS'],
                  ]),

              //Subject 1 Details
              pw.Table.fromTextArray(
                  columnWidths: {
                    0: pw.FlexColumnWidth(4),
                    1: pw.FlexColumnWidth(4),
                    2: pw.FlexColumnWidth(4),
                  },
                  context: context,
                  headerStyle: pw.TextStyle(fontSize: 10),
                  cellStyle: pw.TextStyle(fontSize: 10),
                  data: <List<String>>[
                    <String>["formID", "registrationNumber", "academyStatus"],
                  ]),

              pw.SizedBox(height: 10),

              pw.Table(
                  children: [
                    pw.TableRow(
                        children: [
                          pw.Container(
                              color: PdfColor.fromHex(darkBlue),
                              padding: pw.EdgeInsets.all(6.0),
                              child: pw.Text("Section 1: CHILD'S PERSONAL DETAILS",style: pw.TextStyle(
                                fontSize: 13,
                                color: PdfColor.fromHex(whiteColor),
                                fontWeight: pw.FontWeight.bold,
                              ))
                          ),
                        ]
                    )
                  ]
              ),


              pw.SizedBox(height: 10),


              pw.Table(
                  border: pw.TableBorder.all(color: PdfColor.fromHex("#000000"),width: 0.5),
                  columnWidths: {
                    0: pw.FlexColumnWidth(3),
                    1: pw.FlexColumnWidth(4),
                    2: pw.FlexColumnWidth(3),
                    3: pw.FlexColumnWidth(4)
                  },
                  children: [

                    pw.TableRow(
                        children: [
                          pw.Container(
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("STUDENT NAME",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                          pw.Container(
                            margin: pw.EdgeInsets.all(5.0),
                            child: pw.Text("studentName",style: pw.TextStyle(fontSize: 10),),
                          ),
                          pw.Container(
                              width: 20,
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("FATHER NAME",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                          pw.Container(
                              width: 20,
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("fatherName",style: pw.TextStyle(fontSize: 10),)
                          )
                        ]
                    )  ,

                    pw.TableRow(
                        children: [
                          pw.Container(
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("DATE OF BIRTH",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                          pw.Container(
                            margin: pw.EdgeInsets.all(5.0),
                            child: pw.Text("studentDOB",style: pw.TextStyle(fontSize: 10),),
                          ),
                          pw.Container(
                              width: 20,
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("FATHER CNIC ",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                          pw.Container(
                              width: 20,
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("fatherCNIC",style: pw.TextStyle(fontSize: 10),)
                          )

                        ]
                    ),

                    pw.TableRow(
                        children: [
                          pw.Container(
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("NATIONALITY",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                          pw.Container(
                            margin: pw.EdgeInsets.all(5.0),
                            child: pw.Text("studentNationality",style: pw.TextStyle(fontSize: 10),),
                          ),
                          pw.Container(
                              width: 20,
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("RELIGION ",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                          pw.Container(
                              width: 20,
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("studentReligion",style: pw.TextStyle(fontSize: 10),)
                          )

                        ]
                    ),

                    pw.TableRow(
                        children: [
                          pw.Container(
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("GENDER",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                          pw.Container(
                            margin: pw.EdgeInsets.all(5.0),
                            child: pw.Text("gender",style: pw.TextStyle(fontSize: 10),),
                          ),
                          pw.Container(
                              width: 20,
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                          pw.Container(
                              width: 20,
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("",style: pw.TextStyle(fontSize: 10),)
                          )

                        ]
                    ),

                  ]
              ),

              pw.Table(
                  border: pw.TableBorder.all(color: PdfColor.fromHex("#000000"),width: 0.5),
                  columnWidths: {
                    0: pw.FlexColumnWidth(3),
                    1: pw.FlexColumnWidth(7)
                  },
                  children: [
                    pw.TableRow(
                        children: [
                          pw.Container(
                              width: 20,
                              color: PdfColor.fromHex(amberColor),
                              padding: pw.EdgeInsets.all(5.0),
                              child: pw.Text("MEDICAL CONDITION",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                          pw.Container(
                              width: 20,
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("medicalCondition",style: pw.TextStyle(fontSize: 10),)
                          )
                        ]
                    )
                  ]
              ),

              pw.Table(
                  border: pw.TableBorder.all(color: PdfColor.fromHex("#000000"),width: 0.5),
                  columnWidths: {
                    0: pw.FlexColumnWidth(1.5),
                    1: pw.FlexColumnWidth(7)
                  },
                  children: [
                    pw.TableRow(
                        children: [
                          pw.Container(
                              width: 20,
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("ADDRESS",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                          pw.Container(
                              width: 20,
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("studentAddress",style: pw.TextStyle(fontSize: 10),)
                          )
                        ]
                    )
                  ]
              ),
              pw.Table.fromTextArray(
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#FFBF00"),
                  ),
                  columnWidths: {
                    0: pw.FlexColumnWidth(4),
                    1: pw.FlexColumnWidth(4),
                    2: pw.FlexColumnWidth(4),
                  },
                  context: context,
                  headerStyle: pw.TextStyle(fontSize: 11,fontWeight: pw.FontWeight.bold),
                  cellStyle: pw.TextStyle(fontSize: 10),
                  data: <List<String>>[
                    <String>['FATHER CONTACT NO', 'RESIDENCE NO', 'WHATSAPP NO'],
                  ]),

              //CONTACT NUMBER DETAILS
              pw.Table.fromTextArray(
                  columnWidths: {
                    0: pw.FlexColumnWidth(4),
                    1: pw.FlexColumnWidth(4),
                    2: pw.FlexColumnWidth(4),
                  },
                  context: context,
                  headerStyle: pw.TextStyle(fontSize: 10),
                  cellStyle: pw.TextStyle(fontSize: 10),
                  data: <List<String>>[
                    <String>["contactNumber", "residenceNumber", "whatsappNumber"],
                  ]),

              pw.Table(
                  border: pw.TableBorder.all(color: PdfColor.fromHex("#000000"),width: 0.5),
                  columnWidths: {
                    0: pw.FlexColumnWidth(6),
                    1: pw.FlexColumnWidth(3)
                  },
                  children: [
                    pw.TableRow(
                        children: [
                          pw.Container(
                              color: PdfColor.fromHex(amberColor),
                              padding: pw.EdgeInsets.all(5.0),
                              child: pw.Text("LANGUAGE COMMONLY SPOKEN AT HOME",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                          pw.Container(
                              width: 20,
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("studentLanguage",style: pw.TextStyle(fontSize: 10),)
                          )
                        ]
                    )
                  ]
              ),

              pw.Table(
                  border: pw.TableBorder.all(color: PdfColor.fromHex("#000000"),width: 0.5),

                  children: [
                    pw.TableRow(
                        children: [
                          pw.Container(
                              padding: pw.EdgeInsets.all(5.0),
                              child: pw.Text("Name and Classes of any Brother(s)/Sister(s) attending the academy",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                        ]
                    )
                  ]
              ),

              pw.Table(
                  border: pw.TableBorder.all(color: PdfColor.fromHex("#000000"),width: 0.5),
                  children: [
                    pw.TableRow(
                        children: [
                          pw.Container(
                              width: 20,
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("studentAlreadyAttending",style: pw.TextStyle(fontSize: 10),)
                          )
                        ]
                    )
                  ]
              ),

              pw.SizedBox(height: 10),

              pw.Table(
                  children: [
                    pw.TableRow(
                        children: [
                          pw.Container(
                              color: PdfColor.fromHex(darkBlue),
                              padding: pw.EdgeInsets.all(6.0),
                              child: pw.Text("Section 2: ACADEMIC DETAILS",style: pw.TextStyle(
                                fontSize: 13,
                                color: PdfColor.fromHex(whiteColor),
                                fontWeight: pw.FontWeight.bold,
                              ))
                          ),
                        ]
                    )
                  ]
              ),

              pw.SizedBox(height: 10),

              pw.Table(
                  border: pw.TableBorder.all(color: PdfColor.fromHex("#000000"),width: 0.5),
                  columnWidths: {
                    0: pw.FlexColumnWidth(6),
                    1: pw.FlexColumnWidth(3)
                  },
                  children: [
                    pw.TableRow(
                        children: [
                          pw.Container(
                              padding: pw.EdgeInsets.all(5.0),
                              child: pw.Text("Class in which admission is sought",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                          pw.Container(
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("studentClass",style: pw.TextStyle(fontSize: 10),)
                          )
                        ]
                    )
                  ]
              ),

              pw.Table(
                  border: pw.TableBorder.all(color: PdfColor.fromHex("#000000"),width: 0.5),
                  columnWidths: {
                    0: pw.FlexColumnWidth(6),
                    1: pw.FlexColumnWidth(3)
                  },
                  children: [
                    pw.TableRow(
                        children: [
                          pw.Container(
                              padding: pw.EdgeInsets.all(5.0),
                              child: pw.Text("Student Class group",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                          pw.Container(
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("studentClassGroup",style: pw.TextStyle(fontSize: 10),)
                          )
                        ]
                    )
                  ]
              ),

              pw.Table(
                  border: pw.TableBorder.all(color: PdfColor.fromHex("#000000"),width: 0.5),
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(7)
                  },
                  children: [
                    pw.TableRow(
                        children: [
                          pw.Container(
                              color: PdfColor.fromHex(amberColor),
                              padding: pw.EdgeInsets.all(5.0),
                              child: pw.Text("INSTITUTE NAME",style: pw.TextStyle(
                                  fontSize: 10,color: PdfColor.fromHex("#000000"),fontWeight: pw.FontWeight.bold))
                          ),
                          pw.Container(
                              width: 20,
                              margin: pw.EdgeInsets.all(5.0),
                              child: pw.Text("schoolName",style: pw.TextStyle(fontSize: 10),)
                          )
                        ]
                    )
                  ]
              ),

              pw.SizedBox(height: 30),

              pw.Table(

                  children: [
                    pw.TableRow(
                        children: [
                          pw.Container(
                            margin: pw.EdgeInsets.only(left: 2.0,top: 2.0,bottom: 2.0,right: 5.0),
                            child: pw.Text("Declaration: I ........................hereby certify to the best of my knowledge that the above information is ture and accurate."),
                          ),
                        ]
                    )
                  ]
              ),

              pw.SizedBox(height: 10),


            ],

          ); // Center
        }));


    //=============================================================================================================
    //=============================================================================================================
    //=============================================================================================================


    // pdf.addPage(pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pw.Context context) {
    //       return pw.Column(
    //         mainAxisAlignment: pw.MainAxisAlignment.start,
    //         crossAxisAlignment: pw.CrossAxisAlignment.start,
    //         children: [
    //           pw.Row(
    //               children: [
    //                 pw.Container(
    //                   width: 100,
    //                   child: pw.Image(image),
    //                 ),
    //                 pw.SizedBox(width: 20),
    //                 pw.Column(
    //                     mainAxisAlignment: pw.MainAxisAlignment.center,
    //                     children: [
    //                       pw.Container(
    //                           width: 300,
    //                           alignment: pw.Alignment.center,
    //                           child: pw.Text("Aleezay Group of Academy",style: pw.TextStyle(
    //                             color: PdfColor.fromHex("#00008B"),
    //                             fontSize: 21,
    //                             fontWeight: pw.FontWeight.bold,
    //                           ))
    //                       ),
    //                       pw.Container(
    //                           width: 300,
    //                           padding: pw.EdgeInsets.all(4.0),
    //                           alignment: pw.Alignment.center,
    //                           child: pw.Text("Your Preparation is our Responsibility",style: pw.TextStyle(
    //                             color: PdfColor.fromHex("#00008B"),
    //                             fontSize: 12,
    //                             fontWeight: pw.FontWeight.bold,
    //                           ))
    //                       ),
    //                       pw.Container(
    //                           width: 300,
    //                           padding: pw.EdgeInsets.all(2.0),
    //                           alignment: pw.Alignment.center,
    //                           child: pw.Text("Email: aleezayacademy@gmail.com",style: pw.TextStyle(
    //                             color: PdfColor.fromHex("#FF0000"),
    //                           ))
    //                       ),
    //                       pw.Container(
    //                           width: 300,
    //                           padding: pw.EdgeInsets.all(2.0),
    //                           alignment: pw.Alignment.center,
    //                           child: pw.Text("Whatsapp & Mobile: 03012650333")
    //                       ),
    //                       pw.Container(
    //                           width: 300,
    //                           padding: pw.EdgeInsets.all(2.0),
    //                           alignment: pw.Alignment.center,
    //                           child: pw.Text("Phone: 0412650333")
    //                       ),
    //                       pw.SizedBox(height: 20),
    //
    //                     ]
    //                 ),
    //                 pw.SizedBox(width: 20),
    //
    //                 pw.Container(
    //                     width: 80,
    //                     height: 80,
    //                     padding: pw.EdgeInsets.all(10.0),
    //                     child: pw.Image(imageURL)
    //                 )
    //               ]
    //           ),
    //           pw.Container(
    //               alignment: pw.Alignment.center,
    //               child: pw.Text("APPLICATION FOR REGISTRATION",style: pw.TextStyle(
    //                 fontSize: 16,
    //                 fontWeight: pw.FontWeight.bold,
    //               ))
    //           ),
    //           pw.Container(
    //               padding: pw.EdgeInsets.all(5.0),
    //               alignment: pw.Alignment.center,
    //               child: pw.Text("Please complete each section of BLOCK LETTER using black ink",style: pw.TextStyle(
    //                 fontSize: 11,
    //               ))
    //           ),
    //           pw.SizedBox(height: 10),
    //
    //
    //           pw.Table(
    //               children: [
    //                 pw.TableRow(
    //                     children: [
    //                       pw.Container(
    //                           color: PdfColor.fromHex(darkBlue),
    //                           padding: pw.EdgeInsets.all(6.0),
    //                           child: pw.Text("Section 2: ACADEMIC DETAILS",style: pw.TextStyle(
    //                             fontSize: 13,
    //                             color: PdfColor.fromHex(whiteColor),
    //                             fontWeight: pw.FontWeight.bold,
    //                           ))
    //                       ),
    //                     ]
    //                 )
    //               ]
    //           ),
    //
    //           pw.SizedBox(height: 10),
    //
    //           pw.Table.fromTextArray(
    //               headerDecoration: pw.BoxDecoration(
    //                 color: PdfColor.fromHex("#FFBF00"),
    //               ),
    //               columnWidths: {
    //                 0: pw.FlexColumnWidth(1.0),
    //                 1: pw.FlexColumnWidth(4),
    //                 2: pw.FlexColumnWidth(2.0),
    //                 3: pw.FlexColumnWidth(1.0),
    //                 4: pw.FlexColumnWidth(4.0),
    //                 5: pw.FlexColumnWidth(2.0),
    //               },
    //               context: context,
    //               headerStyle: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold),
    //               cellStyle: pw.TextStyle(fontSize: 10),
    //               data: <List<String>>[
    //                 <String>['SR', 'SUBJECT', 'FEE',"SR","SUBJECT","FEE"],
    //               ]),
    //
    //           //Subject 1 Details
    //           pw.Table.fromTextArray(
    //               columnWidths: {
    //                 0: pw.FlexColumnWidth(1.0),
    //                 1: pw.FlexColumnWidth(4),
    //                 2: pw.FlexColumnWidth(2.0),
    //                 3: pw.FlexColumnWidth(1.0),
    //                 4: pw.FlexColumnWidth(4.0),
    //                 5: pw.FlexColumnWidth(2.0),
    //               },
    //               context: context,
    //               headerStyle: pw.TextStyle(fontSize: 10),
    //               cellStyle: pw.TextStyle(fontSize: 10),
    //               data: <List<String>>[
    //                 <String>['1', subject1, subject1Price,'6', subject6, subject6Price],
    //               ]),
    //
    //           //Subject 2 Details
    //           pw.Table.fromTextArray(
    //               columnWidths: {
    //                 0: pw.FlexColumnWidth(1.0),
    //                 1: pw.FlexColumnWidth(4),
    //                 2: pw.FlexColumnWidth(2.0),
    //                 3: pw.FlexColumnWidth(1.0),
    //                 4: pw.FlexColumnWidth(4.0),
    //                 5: pw.FlexColumnWidth(2.0),
    //               },
    //               context: context,
    //               headerStyle: pw.TextStyle(fontSize: 10),
    //               cellStyle: pw.TextStyle(fontSize: 10),
    //               data: <List<String>>[
    //                 <String>['2', subject2, subject2Price,'7', subject7, subject7Price],
    //               ]),
    //
    //           //Subject 3 Details
    //           pw.Table.fromTextArray(
    //               columnWidths: {
    //                 0: pw.FlexColumnWidth(1.0),
    //                 1: pw.FlexColumnWidth(4),
    //                 2: pw.FlexColumnWidth(2.0),
    //                 3: pw.FlexColumnWidth(1.0),
    //                 4: pw.FlexColumnWidth(4.0),
    //                 5: pw.FlexColumnWidth(2.0),
    //               },
    //               context: context,
    //               headerStyle: pw.TextStyle(fontSize: 10),
    //               cellStyle: pw.TextStyle(fontSize: 10),
    //               data: <List<String>>[
    //                 <String>['3', subject3, subject3Price,'8', subject8, subject8Price],
    //               ]),
    //
    //           //Subject 4 Details
    //           pw.Table.fromTextArray(
    //               columnWidths: {
    //                 0: pw.FlexColumnWidth(1.0),
    //                 1: pw.FlexColumnWidth(4),
    //                 2: pw.FlexColumnWidth(2.0),
    //                 3: pw.FlexColumnWidth(1.0),
    //                 4: pw.FlexColumnWidth(4.0),
    //                 5: pw.FlexColumnWidth(2.0),
    //               },
    //               context: context,
    //               headerStyle: pw.TextStyle(fontSize: 10),
    //               cellStyle: pw.TextStyle(fontSize: 10),
    //               data: <List<String>>[
    //                 <String>['4', subject4, subject4Price,'9', subject9, subject9Price],
    //               ]),
    //
    //           //Subject 5 Details
    //           pw.Table.fromTextArray(
    //               columnWidths: {
    //                 0: pw.FlexColumnWidth(1.0),
    //                 1: pw.FlexColumnWidth(4),
    //                 2: pw.FlexColumnWidth(2.0),
    //                 3: pw.FlexColumnWidth(1.0),
    //                 4: pw.FlexColumnWidth(4.0),
    //                 5: pw.FlexColumnWidth(2.0),
    //               },
    //               context: context,
    //               headerStyle: pw.TextStyle(fontSize: 10),
    //               cellStyle: pw.TextStyle(fontSize: 10),
    //               data: <List<String>>[
    //                 <String>['5', subject5, subject5Price,'', '', ''],
    //               ]),
    //
    //
    //           pw.SizedBox(height: 10),
    //
    //           pw.Table(
    //               children: [
    //                 pw.TableRow(
    //                     children: [
    //                       pw.Container(
    //                           color: PdfColor.fromHex(darkBlue),
    //                           padding: pw.EdgeInsets.all(6.0),
    //                           child: pw.Text("FEE DETAILS",style: pw.TextStyle(
    //                             fontSize: 13,
    //                             color: PdfColor.fromHex(whiteColor),
    //                             fontWeight: pw.FontWeight.bold,
    //                           ))
    //                       ),
    //                     ]
    //                 )
    //               ]
    //           ),
    //
    //
    //           pw.SizedBox(height: 10),
    //
    //           pw.Table.fromTextArray(
    //               headerDecoration: pw.BoxDecoration(
    //                 color: PdfColor.fromHex("#FFBF00"),
    //               ),
    //               columnWidths: {
    //                 0: pw.FlexColumnWidth(3),
    //                 1: pw.FlexColumnWidth(3),
    //                 2: pw.FlexColumnWidth(3),
    //                 3: pw.FlexColumnWidth(3),
    //                 4: pw.FlexColumnWidth(3),
    //               },
    //               context: context,
    //               headerStyle: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold),
    //               cellStyle: pw.TextStyle(fontSize: 10),
    //               data: <List<String>>[
    //                 <String>['Daily Test', 'Services Fee', 'Extra Fee',"Discount Fee","Subject Fee"],
    //               ]),
    //
    //           //Fee Details
    //           pw.Table.fromTextArray(
    //               columnWidths: {
    //                 0: pw.FlexColumnWidth(3),
    //                 1: pw.FlexColumnWidth(3),
    //                 2: pw.FlexColumnWidth(3),
    //                 3: pw.FlexColumnWidth(3),
    //                 4: pw.FlexColumnWidth(3),
    //               },
    //               context: context,
    //               headerStyle: pw.TextStyle(fontSize: 10),
    //               cellStyle: pw.TextStyle(fontSize: 10),
    //               data: <List<String>>[
    //                 <String>['PKR $dailyTestCharges', 'PKR $serviceCharges', 'PKR $extraCharges','PKR $discount'.toString(),'PKR ${
    //                     int.parse(subject1Price) + int.parse(subject2Price) +
    //                         int.parse(subject3Price) + int.parse(subject4Price)
    //                         + int.parse(subject5Price) +int.parse(subject6Price)
    //                         + int.parse(subject7Price) + int.parse(subject8Price) +int.parse(subject9Price)
    //                 }'],
    //               ]),
    //
    //           pw.SizedBox(height: 20),
    //
    //           pw.Container(
    //             alignment: pw.Alignment.centerRight,
    //             padding: pw.EdgeInsets.all(2.0),
    //             child: pw.Text("Total Dues",style: pw.TextStyle(
    //               color: PdfColor.fromHex("#FF0000"),
    //               fontSize: 12,
    //               fontWeight: pw.FontWeight.bold,
    //             ),),
    //           ),
    //           pw.Container(
    //             alignment: pw.Alignment.centerRight,
    //             padding: pw.EdgeInsets.all(2.0),
    //             child: pw.Text("PKR $totalDues is $feeStatus",style: pw.TextStyle(
    //               fontSize: 12,
    //               fontWeight: pw.FontWeight.bold,
    //             ),),
    //           ),
    //
    //           pw.SizedBox(height: 10),
    //
    //           pw.Table(
    //               children: [
    //                 pw.TableRow(
    //                     children: [
    //                       pw.Container(
    //                           color: PdfColor.fromHex(darkBlue),
    //                           padding: pw.EdgeInsets.all(6.0),
    //                           child: pw.Text("PARENT APP ACCOUNT DETAILS",style: pw.TextStyle(
    //                             fontSize: 13,
    //                             color: PdfColor.fromHex(whiteColor),
    //                             fontWeight: pw.FontWeight.bold,
    //                           ))
    //                       ),
    //                     ]
    //                 )
    //               ]
    //           ),
    //
    //           pw.SizedBox(height: 10),
    //
    //
    //           pw.Table.fromTextArray(
    //               headerDecoration: pw.BoxDecoration(
    //                 color: PdfColor.fromHex(amberColor),
    //               ),
    //               columnWidths: {
    //                 0: pw.FlexColumnWidth(4),
    //                 1: pw.FlexColumnWidth(4),
    //                 2: pw.FlexColumnWidth(4),
    //                 3: pw.FlexColumnWidth(4),
    //               },
    //               context: context,
    //               headerStyle: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold),
    //               cellStyle: pw.TextStyle(fontSize: 10),
    //               data: <List<String>>[
    //                 <String>['ATTENDENCE QR','APP USERNAME', 'APP PASSWORD', 'APP QRCODE'],
    //               ]),
    //
    //           pw.Table(
    //               columnWidths: {
    //                 0: pw.FlexColumnWidth(4),
    //                 1: pw.FlexColumnWidth(4),
    //                 2: pw.FlexColumnWidth(4),
    //                 3: pw.FlexColumnWidth(4),
    //               },
    //               border: pw.TableBorder.all(color: PdfColor.fromHex(blackColor),width: 0.5),
    //               children: [
    //                 pw.TableRow(
    //                     children: [
    //                       pw.Container(
    //                         width: 80,
    //                         height: 80,
    //                         padding: pw.EdgeInsets.all(10.0),
    //                         child: pw.BarcodeWidget(
    //                           color: PdfColor.fromHex("#000000"),
    //                           barcode: pw.Barcode.qrCode(),
    //                           data: formID.toString(),
    //                         ),
    //                       ),
    //                       pw.Container(
    //                         padding: pw.EdgeInsets.all(5.0),
    //                         child: pw.Text(fatherCNIC),
    //                       ),
    //                       pw.Container(
    //                         padding: pw.EdgeInsets.all(5.0),
    //                         child: pw.Text("12345"),
    //                       ),
    //                       pw.Container(
    //                         width: 80,
    //                         height: 80,
    //                         padding: pw.EdgeInsets.all(10.0),
    //                         child: pw.BarcodeWidget(
    //                           color: PdfColor.fromHex("#000000"),
    //                           barcode: pw.Barcode.qrCode(),
    //                           data: "My data",
    //                         ),
    //                       )
    //                     ]
    //                 )
    //               ]
    //           ),
    //
    //           pw.SizedBox(height: 30),
    //
    //           pw.Table(
    //               columnWidths: {
    //                 0: pw.FlexColumnWidth(4),
    //                 1: pw.FlexColumnWidth(4),
    //               },
    //               children: [
    //                 pw.TableRow(
    //                     children: [
    //                       pw.Container(
    //                         margin: pw.EdgeInsets.only(left: 2.0,top: 2.0,bottom: 2.0,right: 5.0),
    //                         child: pw.Text("Student's Signature__________________"),
    //                       ),
    //                       pw.Container(
    //                         margin: pw.EdgeInsets.only(left: 5.0,top: 2.0,bottom: 2.0,right: 2.0),
    //                         child: pw.Text("Parent's Signature____________________"),
    //                       )
    //                     ]
    //                 )
    //               ]
    //           ),
    //
    //
    //         ],
    //
    //       ); // Center
    //     }));





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
