
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_schools_admin/config/component/app_text_widget.dart';
import 'package:legends_schools_admin/config/component/button_widget.dart';
import 'package:legends_schools_admin/config/component/custom_richtext.dart';
import 'package:legends_schools_admin/constant.dart';
import 'package:legends_schools_admin/model/fee/fee_status_model.dart';
import 'package:legends_schools_admin/model/registration_form_model.dart';
import 'package:legends_schools_admin/provider/fee_management_provider.dart';
import 'package:legends_schools_admin/provider/registration/registration_provider.dart';
import 'package:legends_schools_admin/screens/fees/view/student_all_fee_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../expense/studentExpense/view/student_expense_list_widget.dart';

class PayFeeScreen extends StatelessWidget {
  const PayFeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeeManagementProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonWidget(
                text: "Back to Home",
                onClicked: () async{
                  Get.back();
                }
            ),
            const SizedBox(height: 30,),
            AppTextWidget(
              text: "Student Monthly Fee",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 30,),
            _profileView(model: provider.feeStatusModel!),

            const SizedBox(height: 30,),
            _currentDues(),
            const SizedBox(height: 30,),


            AppTextWidget(
              text: "Student Expense (November)",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            StudentExpenseListWidget(
              formID: provider.feeStatusModel!.students!.formId,
              isSearch: false,
            ),
            const SizedBox(height: 30,),
            AppTextWidget(
              text: "Dues History",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 30,),
            StudentAllFeeListWidget(formID: provider.feeStatusModel!.students!.formId,),

          ],
        ),
      ),
    );
  }

  Widget _profileView({required FeeStatusModel model}) {
    log("Image URL: ${model.students!.pdfImageUrl}");
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1: Profile Picture
          SizedBox(
            width: 200,
            height: 200,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  model.students!.pdfImageUrl,
                  width: 30.w,
                  height: 30.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 30.w,
                      height: 30.w,
                      color: Colors.grey[200],
                      child: const Icon(Icons.person, size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 30),

          // Section 2: Basic Details
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 20),
                CustomRichText(firstText: "Form Number: ", secondText: model.students!.formId),
                const SizedBox(height: 20),
                CustomRichText(firstText: "Student Name: ", secondText: model.students!.name),
                const SizedBox(height: 20),
                CustomRichText(firstText: "Father's Name: ", secondText: model.students!.fatherName),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Section 3: Additional Details
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CustomRichText(firstText: "Father's CNIC: ", secondText: model.students!.fatherCNIC),
                const SizedBox(height: 20),
                CustomRichText(firstText: "Class Name: ", secondText: model.students!.className),
                const SizedBox(height: 20),
                CustomRichText(firstText: "Contact Number: ", secondText: model.students!.contactNumber),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _currentDues(){
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextWidget(
            text: "Current Dues Details",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

}
