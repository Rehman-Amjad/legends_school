
import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_schools_admin/config/component/app_text_field.dart';
import 'package:legends_schools_admin/config/component/app_text_widget.dart';
import 'package:legends_schools_admin/config/component/button_widget.dart';
import 'package:legends_schools_admin/config/component/custom_richtext.dart';
import 'package:legends_schools_admin/config/component/search_calender_dropdpwn.dart';
import 'package:legends_schools_admin/config/util/time_utils.dart';
import 'package:legends_schools_admin/constant.dart';
import 'package:legends_schools_admin/model/daily_expense_model.dart';
import 'package:legends_schools_admin/model/registration_form_model.dart';
import 'package:legends_schools_admin/provider/constant/action_provider.dart';
import 'package:legends_schools_admin/provider/constant/drop_down_provider.dart';
import 'package:legends_schools_admin/provider/fee_management_provider.dart';
import 'package:legends_schools_admin/provider/registration/registration_provider.dart';
import 'package:legends_schools_admin/screens/expense/studentExpense/view/student_expense_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/constant/constant_widget.dart';
import '../../../config/util/app_utils.dart';

class AddStudentExpenseScreen extends StatelessWidget {
  const AddStudentExpenseScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistrationProvider>(context,listen: false);
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
               text: "Add Student Daily Expense",
               fontSize: 20,
               fontWeight: FontWeight.bold,
           ),
           const SizedBox(height: 30,),
            _profileView(model: provider.student),
            const SizedBox(height: 30,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                    child: _addExpenseView(
                        model: provider.student,
                       context: context
                    )
                ),
               const SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: _expenseHistory(model: provider.student,)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _profileView({required RegistrationFormModel model}) {
    log("Image URL: ${model.pdfImageUrl}");
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(10),
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
                  model.pdfImageUrl,
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
                CustomRichText(firstText: "Form Number: ", secondText: model.formId),
                const SizedBox(height: 20),
                CustomRichText(firstText: "Student Name: ", secondText: model.name),
                const SizedBox(height: 20),
                CustomRichText(firstText: "Father's Name: ", secondText: model.fatherName),
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
                CustomRichText(firstText: "Father's CNIC: ", secondText: model.fatherCNIC),
                const SizedBox(height: 20),
                CustomRichText(firstText: "Class Name: ", secondText: model.className),
                const SizedBox(height: 20),
                CustomRichText(firstText: "Contact Number: ", secondText: model.contactNumber),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _addExpenseView({required RegistrationFormModel model,required BuildContext context}){
    final dropP = Provider.of<DropdownProvider>(context,listen: false);
    final feeP = Provider.of<FeeManagementProvider>(context,listen: false);
    return Container(
      padding:const  EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextWidget(
              text: "Add Expense",
              fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20,),
          AppTextWidget(text: "Expense Type"),
          const SizedBox(height: 10,),
          CustomDropdown<String>(
            hintText: 'Choose Expense Type',
            items: dropP.studentExpenseList,
            onChanged: (category) {
              int index =  dropP.studentExpenseList.indexOf(category!);
              dropP.updateExpenseType(index);
            },
            validateOnChange: true,
            validator: (value){
              if(value ==null){
                return "Select Expense Type";
              }
              return null;
            },
            decoration: decoration(
              bolderColor: Colors.transparent,
              headerFontSize: 14.0,
              fillColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 20,),

          // date
          // const SizedBox(height: 20,),
          // AppTextWidget(text: "Expense Date"),
          // const SizedBox(height: 10,),
          // ShadDatePickerFormField(
          //   backgroundColor: Colors.grey[200],
          //   label: const Text('Date of birth',style: TextStyle(color: Colors.black),),
          //   initialValue: DateTime.now(),
          //   onChanged: (date){
          //     print(date);
          //   },
          //
          //   description: const Text(
          //       'Your date of birth is used to calculate your age.'),
          //   validator: (v) {
          //     if (v == null) {
          //       return 'A date of birth is required.';
          //     }
          //     return null;
          //   },
          // ),
          //
          // //Amount
          // const SizedBox(height: 20,),
          AppTextWidget(text: "Amount"),
         const SizedBox(height: 10,),
          AppTextField(
            controller: feeP.amountController,
              hintText: "Amount (PKR)",
            fillColor: Colors.grey[200],
            borderColor: Colors.grey[200],
          ),
          const SizedBox(height: 20,),

          AppTextWidget(text: "Note"),
          const SizedBox(height: 10,),
          AppTextField(
            controller: feeP.noteController,
            hintText: "Note Here",
            maxLine: 5,
            fillColor: Colors.grey[200],
            borderColor: Colors.grey[200],
          ),
          const SizedBox(height: 20,),
          ButtonWidget(
              index: 2,
              text: "Save",
              onClicked: () async{
                ActionProvider.startLoading(index: 2);
                final expense = DailyExpenseModel(
                    timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
                    amount: double.parse(feeP.amountController.text),
                    description: feeP.noteController.text,
                    category: dropP.selectedExpense,
                    paymentMethod: "none",
                    monthYear: TimeUtils().getMonthYearFromTimestamp()
                );
               await feeP.addExpense(model.formId, expense);
                AppUtils().showWebToast(
                    text: "Expense Add Successful"
                );
                ActionProvider.stopLoading(index: 2);

              }
          )

        ],
      ),
    );
  }


  Widget _expenseHistory({required RegistrationFormModel model}){
    return Container(
      padding:const  EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextWidget(
            text: "Expense History",
            fontWeight: FontWeight.bold,
          ),
         const SizedBox(height: 20,),
         const SearchCalenderDropdown(),
         const SizedBox(height: 20,),
          StudentExpenseListWidget(formID: model.formId),
        ],
      ),
    );
  }



}
