
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../model/registration_form_model.dart';
import '../../../../../pdf_preview_screen.dart';
import '../../../../res/app_assets.dart';
import '../../../widget/pdf_card_back_widget.dart';
import '../../../widget/pdf_card_widget.dart';


class StudentCardPdf{

  Future<void> generatePDF(
      BuildContext context,
      List<RegistrationFormModel> studentsList
      ) async {
    final pdf = pw.Document();

    // Fetch student images
    List<pw.MemoryImage> studentImages = [];
    for (var student in studentsList.take(5)) {
      try {
        final response = await http.get(Uri.parse(student.pdfImageUrl));
        if (response.statusCode == 200) {
          studentImages.add(pw.MemoryImage(response.bodyBytes));
        } else {
          throw Exception('Failed to load image for student: ${student.formId}');
        }
      } catch (e) {
        log('Error loading image for student: ${student.formId}. Error: $e');
        // Handle the error appropriately, e.g., use a placeholder image or skip the student
      }
    }

    final logoImage = pw.MemoryImage((await rootBundle.load(AppAssets.logo))
        .buffer.asUint8List());
    final facebookImage = pw.MemoryImage((await rootBundle.load(AppAssets.facebook))
        .buffer.asUint8List());
    final whatsappImage = pw.MemoryImage((await rootBundle.load(AppAssets.whatsapp))
        .buffer.asUint8List());
    final webImage = pw.MemoryImage((await rootBundle.load(AppAssets.location))
        .buffer.asUint8List());
    final emailImage = pw.MemoryImage((await rootBundle.load(AppAssets.gmail))
        .buffer.asUint8List());
    final playImage = pw.MemoryImage((await rootBundle.load(AppAssets.game))
        .buffer.asUint8List());

    final defaultHeight = pw.SizedBox(height: 10.0);


    List<pw.Widget> widgets = [];
    List<pw.Widget> backCardsWidget = [];


    // Add cards to the widgets list
    for (int i = 0; i < studentsList.length && i < 5; i++) {
      final student = studentsList[i];
      final cardFront = PdfCardFrontWidget(
        id: student.formId.toString(),
        name: student.name.toString(),
        fatherName: student.fatherName.toString(),
        dob: student.studentDOB.toString(),
        registrationNo: student.registrationNumber.toString(),
        className: student.className.toString(),
        group: student.groupName.toString(),
        gender: student.gender.toString(),
        image: logoImage,
        imageUrl: studentImages[i],
      );
      final backCard = PdfCardBackWidget(
        id: student.formId.toString(),
        facebookImage: facebookImage,
        emailImage: emailImage,
        webImage: webImage,
        whatsappImage: whatsappImage,
        playStoreImage: playImage
      );
      widgets.add(cardFront);
      backCardsWidget.add(backCard);
    }

    // final card1Front =  PdfCardFrontWidget(
    //   id: "studentsList[0].studentFormID.toString()",
    //   name: "studentsList[0].studentName.toString()",
    //   fatherName: "studentsList[0].fatherName.toString()",
    //   dob: "studentsList[0].studentDOB.toString()",
    //   registrationNo:" studentsList[0].studentRegistrationNumber.toString()",
    //   className: "studentsList[0].studentClassName.toString()",
    //   group: "studentsList[0].studentGroupName.toString()",
    //   gender: "studentsList[0].gender.toString()",
    // );


    pdf.addPage(pw.Page(
        margin: const pw.EdgeInsets.all(10.0),
        pageFormat: PdfPageFormat.a4.landscape,
        build: (context) {
          return pw.Column(
            children: [
              pw.SizedBox(height: 20.0),
              pw.Row(
                children: widgets
              ),
              pw.SizedBox(height: 20.0),
              pw.Row(
                  children: backCardsWidget
              ),
            ]
          );
        }));

    Get.to(()=> PdfPreviewScreen(pdf: pdf, pdfName: "card"));
  }



}





