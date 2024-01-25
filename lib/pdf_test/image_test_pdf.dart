import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'dart:html' as html;

class PdfImageTester extends StatefulWidget {
  const PdfImageTester({Key? key}) : super(key: key);

  @override
  State<PdfImageTester> createState() => _PdfImageTesterState();
}

class _PdfImageTesterState extends State<PdfImageTester> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: ElevatedButton(
        child: Text("Download"),
    onPressed: (){
    generatePDF(context);
    },
    )),
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
    String? imagepath = "https://firebasestorage.googleapis.com/v0/b/legends-school.appspot.com/o/StudentAdmissionFormImage%2F2023-11-23%2022%3A32%3A05.698?alt=media&token=7ae23ea9-6ee5-4761-ada3-24e0f07d63be";
    final response = await http.get(Uri.parse(imagepath));

    print("Respnse Code before Condition: ${response.statusCode}");
    if(response.statusCode == 200){

      print('Response Code: ${response.statusCode}');
      final image = pw.MemoryImage(response.bodyBytes);
      
      var today = DateTime.now();
      var dateFormat = DateFormat('dd-MM-yyyy');
      String currentTime = DateFormat("hh:mm:ss a").format(DateTime.now());
      String currentDate = dateFormat.format(today);
      pdfFileName = "${"formID".toString()}_${currentDate.toString()}.pdf";
      print(pdfFileName);

      // final  imageBytes = await rootBundle.load('assets/images/admin.png');
      // final image = pw.MemoryImage(imageBytes.buffer.asUint8List());
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
                          child: pw.Text("")
                        // child: pw.Image(imageURL)
                      )
                    ]
                ),




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
    else{
      print("Respnse Code: ${response.statusCode}");
    }

   





    // final ref = FirebaseStorage.instance.ref().child('image_1683791555842.jpg');
    // final imageData = await ref.getData();
    // final imageURL = pw.MemoryImage(imageData!);


   
  }
}
