
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/res/app_assets.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import '../../config/component/app_text_field.dart';
import '../../config/pdf/design/studentCard/view/student_card_pdf.dart';
import '../../provider/studentCard/student_card_provider.dart';

class StudentCardScreen extends StatelessWidget {
  final studentID1Controller = TextEditingController();
  final studentID2Controller = TextEditingController();
  final studentID3Controller = TextEditingController();
  final studentID4Controller = TextEditingController();
  final studentID5Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Card Search / Generate"),
      ),
      body: Consumer<StudentCardProvider>(
        builder: (context, studentProvider, child) {
          return ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    alignment: AlignmentDirectional.center,
                    height: 150,
                    child: Image.asset(AppAssets.logo),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      studentProvider.taskText,
                      style:const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 300,
                          height: 50,
                          child: AppTextField(
                            hintText: "Student ID",
                            controller: studentID1Controller,
                          )
                      ),
                      SizedBox(width: 10),
                      Container(
                          width: 300,
                          height: 50,
                          child: AppTextField(
                            hintText: "Student ID",
                            controller: studentID2Controller,
                          )
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 300,
                        height: 50,
                        child: AppTextField(
                          hintText: "Student ID",
                          controller: studentID3Controller,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 50,
                        child: AppTextField(
                          hintText: "Student ID",
                          controller: studentID4Controller,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 300,
                        height: 50,
                        child: AppTextField(
                          hintText: "Student ID",
                          controller: studentID5Controller,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 150,
                        height: 60,
                        padding: EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: () async{
                            List<String> studentIDs = [
                              studentID1Controller.text.toString(),
                              studentID2Controller.text.toString(),
                              studentID3Controller.text.toString(),
                              studentID4Controller.text.toString(),
                              studentID5Controller.text.toString(),
                            ];
                            await studentProvider.fetchStudentDetails(studentIDs);
                            log("Number of students fetched: ${studentProvider.students[0].formId}");
                            StudentCardPdf().generatePDF(context, studentProvider.students);
                          },
                          child: Text("Generate Card"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }



}
