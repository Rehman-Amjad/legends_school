

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:legends_schools_admin/config/res/app_assets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/pdf/color/pdf_color.dart';
import '../../../config/pdf/widget/pdf_text_widget.dart';
import '../../../config/res/app_string.dart';
import '../../../model/registration_form_model.dart';
import '../../../pdf_preview_screen.dart';
import '../../../provider/constant/picker_provider.dart';
import 'components/full_head_pdf.dart';
import 'components/header_design.dart';
import 'components/parent_account_detaills_pdf.dart';
import 'components/signature_pdf.dart';
import 'components/table2Column.dart';
import 'components/table3Column.dart';
import 'components/table4Column.dart';
import 'components/table5Column.dart';


class RegistrationPdf{

  Future<void> generatePDF(
      BuildContext context,
      RegistrationFormModel student
      ) async {
    final pdf = pw.Document();
    final imageProvider = Provider.of<PickerProvider>(context,listen: false);
    final logoImage = pw.MemoryImage((await rootBundle.load(AppAssets.logo)).buffer.asUint8List());

    final defaultHeight = pw.SizedBox(height: 10.0);


    List<pw.Widget> widgets = [];


    final header  = RegistrationHeaderPdf(image: logoImage,pickedImage:imageProvider.pickedImage);

    final stRegHead = Table3columnPdf(
      text1: "FORM ID",
      color1: PdfColors.blueAccent,
      text2: "REGISTRATION NUMBER",
      color2: PdfColors.blueAccent,
      text3: "COACHING STATUS",
      color3: PdfColors.blueAccent,
    );

    final stRegHeadDetails = Table3columnPdf(
      text1: student.formId,
      text2: student.registrationNumber,
      text3: student.status,
      isText1: false,
      isText2: false,
      isText3: false,
    );


    // student Personal Details
    final studentDetails1 = Table4columnPdf(
        text1: "STUDENT NAME",
        text2: student.name.toString().toUpperCase(),
        isText2: false,
        text3: "FATHER NAME",
        text4: student.fatherName.toString().toUpperCase(),
        isText4: false
    );

    final studentDetails2 = Table4columnPdf(
        text1: "DATE OF BIRTH",
        text2: student.studentDOB.toString().toUpperCase(),
        isText2: false,
        text3: "FATHER CNIC",
        text4: student.fatherCNIC.toString().toUpperCase(),
        isText4: false
    );

    final studentDetails3 = Table4columnPdf(
        text1: "NATIONALITY",
        text2: student.nationality.toString().toUpperCase(),
        isText2: false,
        text3: "RELIGION",
        text4: student.religion.toString().toUpperCase(),
        isText4: false
    );

    final studentDetails4 = Table4columnPdf(
        text1: "GENDER",
        text2: student.gender.toString().toUpperCase(),
        isText2: false,
        text3: "MEDICAL CONDITION",
        text4: student.medicalCondition.toString().toUpperCase(),
        isText4: false
    );

    final address = Table2columnPdf(
        text1: "ADDRESS",
        flex1: 1,
        text2: student.address.toString().toUpperCase(),
        isText2: false,
        textAlign2: pw.TextAlign.start,
        flex2: 2
    );

    final contactHead = Table3columnPdf(
      text1: "FATHER CONTACT NO",
      color1: PdfColors.blueAccent,
      text2: "RESIDENCE NO",
      color2: PdfColors.blueAccent,
      text3: "WHATSAPP NO",
      color3: PdfColors.blueAccent,
    );

    final contactDetails = Table3columnPdf(
      text1: student.contactNumber,
      text2: student.residenceNumber,
      text3: student.whatsappNumber,
      isText1: false,
      isText2: false,
      isText3: false,
    );

    final language = Table2columnPdf(
        text1: "FATHER OCCUPATION".toUpperCase(),
        flex1: 2,
        color1: PdfColors.blueAccent,
        textAlign1: pw.TextAlign.start,
        text2: student.fatherOccupation.toString().toUpperCase(),
        isText2: false,
        textAlign2: pw.TextAlign.start,
        flex2: 1
    );

    final attendAcademy = Table2columnPdf(
        text1: "Name and Classes of any Brother(s)/Sister(s) attending the academy".toUpperCase(),
        flex1: 2,
        color1: PdfColors.white,
        textAlign1: pw.TextAlign.start,
        text2: student.referenceName.toString().toUpperCase(),
        isText2: false,
        textAlign2: pw.TextAlign.start,
        flex2: 1
    );

    final admissionSought = Table2columnPdf(
        text1: "Class in which admission is sought".toUpperCase(),
        flex1: 2,
        color1: PdfColors.white,
        textAlign1: pw.TextAlign.start,
        text2: student.className.toString().toUpperCase(),
        isText2: false,
        textAlign2: pw.TextAlign.start,
        flex2: 1
    );

    final classGroup = Table2columnPdf(
        text1: "Student Class group".toUpperCase(),
        flex1: 2,
        color1: PdfColors.white,
        textAlign1: pw.TextAlign.start,
        text2: student.groupName.toString().toUpperCase(),
        isText2: false,
        textAlign2: pw.TextAlign.start,
        flex2: 1
    );

    final instituteName = Table2columnPdf(
        text1: "INSTITUTE NAME".toUpperCase(),
        flex1: 1,
        color1: PdfColors.blueAccent,
        textAlign1: pw.TextAlign.start,
        text2: student.schoolName.toString().toUpperCase(),
        isText2: false,
        textAlign2: pw.TextAlign.start,
        flex2: 3
    );




    final feeTable = Table5columnPdf(
      text1: "Daily Test".toUpperCase(),
      text2: "Services Charges".toUpperCase(),
      text3: "Extra Charges".toUpperCase(),
      text4: "Discount Fee".toUpperCase(),
      color1: PdfColors.blueAccent,
      color2: PdfColors.blueAccent,
      color3: PdfColors.blueAccent,
      color4: PdfColors.blueAccent,
      color5: PdfColors.blueAccent,
    );
    final feeDetailsTable = Table5columnPdf(
        text1: student.dailyTest,
        text2: student.servicesFee,
        text3: student.extraCharges,
        text4: student.discountCharges,
    );


    final totalDues = pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          PdfTextWidget(text: "", color: PdfColors.white, size: 12.0, isBold: false),
          pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                PdfTextWidget(text: "Total Dues", color: PdfColors.red, size: 14.0, isBold: false),
                PdfTextWidget(text: "PKR ${student.totalDues}", color: PdfColors.black, size: 12.0, isBold: false),
              ]
          )
        ]
    );

    final appAccountHead = Table4columnPdf(
      text1: "ATTENDANCE QR",
      text2: "APP USERNAME",
      text3: "APP PASSWORD",
      text4: "APP QRCODE",
      color1: PdfColors.blueAccent,
      color2: PdfColors.blueAccent,
      color3: PdfColors.blueAccent,
      color4: PdfColors.blueAccent,
    );


    widgets.add(header);
    widgets.add(stRegHead);
    widgets.add(stRegHeadDetails);
    widgets.add(defaultHeight);
    widgets.add(FullHeadPdfText(
        text: 'SECTION 1: STUDENT PERSONAL DETAILS',
        backgroundColor: blueColor, textColor: PdfColors.white));
    widgets.add(defaultHeight);
    widgets.add(studentDetails1);
    widgets.add(studentDetails2);
    widgets.add(studentDetails3);
    widgets.add(studentDetails4);
    widgets.add(address);
    widgets.add(contactHead);
    widgets.add(contactDetails);
    widgets.add(language);
    widgets.add(attendAcademy);
    widgets.add(defaultHeight);
    widgets.add(FullHeadPdfText(
        text: 'SECTION 2: ACADEMIC DETAILS',
        backgroundColor: blueColor, textColor: PdfColors.white));
    widgets.add(defaultHeight);
    widgets.add(admissionSought);
    widgets.add(classGroup);
    widgets.add(instituteName);
    widgets.add(pw.SizedBox(height: 40.0));
    widgets.add(PdfTextWidget(
        text: AppString.signatureText,
        color: PdfColors.black,
        size: 14.0,
        isBold: false
    ));
    widgets.add(pw.SizedBox(height: 50.0));
    widgets.add(SignaturePdf());

    widgets.add(pw.SizedBox(height: 40.0));
    widgets.add(header);
    widgets.add(defaultHeight);
    widgets.add(FullHeadPdfText(
        text: 'FEE DETAILS',
        backgroundColor: blueColor, textColor: PdfColors.white));
    widgets.add(defaultHeight);
    widgets.add(feeTable);
    widgets.add(feeDetailsTable);
    widgets.add(pw.SizedBox(height: 50.0));
    widgets.add(SignaturePdf());
    widgets.add(defaultHeight);
    widgets.add(totalDues);
    widgets.add(pw.SizedBox(height: 30.0));
    widgets.add(appAccountHead);
    widgets.add(ParentAccountDetaillsPdf(formID: student.formId, fatherCNIC: student.fatherCNIC));
    widgets.add(defaultHeight);


    pdf.addPage(pw.MultiPage(
        margin: const pw.EdgeInsets.all(40.0),
        pageFormat: PdfPageFormat.a4,
        build: (context) => widgets));

    Get.to(()=> PdfPreviewScreen(pdf: pdf, pdfName: "${student.formId}-${student.name}-${student.className}"));
  }



}





