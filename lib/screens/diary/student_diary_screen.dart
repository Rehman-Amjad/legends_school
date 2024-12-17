import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/util/app_utils.dart';
import 'package:legends_schools_admin/model/diary/diary_model.dart';
import 'package:legends_schools_admin/provider/constant/action_provider.dart';
import 'package:legends_schools_admin/provider/diary/diary_provider.dart';
import 'package:legends_schools_admin/screens/diary/component/diary_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../config/component/app_text_field.dart';
import '../../config/component/app_text_widget.dart';
import '../../config/component/button_widget.dart';
import '../../config/constant/constant_widget.dart';
import '../../constant.dart';

class StudentDiaryScreen extends StatelessWidget {
  const StudentDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask((){
      context.read<DiaryProvider>().clearDateFilter();
    });
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: _addDiaryView(
                        context: context
                    )
                ),
                const SizedBox(width: 20,),
                Expanded(
                    flex: 2,
                    child: _diaryHistory()
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _addDiaryView({required BuildContext context}){
    final diaryP = Provider.of<DiaryProvider>(context,listen: false);
    // final feeP = Provider.of<FeeManagementProvider>(context,listen: false);
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
            text: "Add Student Diary",
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20,),
          AppTextWidget(
            text: "Select Class",
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20,),
          CustomDropdown<String>(
            hintText: 'Choose Class',
            items: diaryP.classList,
            onChanged: (category) {
              int index =  diaryP.classList.indexOf(category!);
              diaryP.updateClass(index);
            },
            validateOnChange: true,
            validator: (value){
              if(value ==null){
                return "Select Class";
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

          AppTextWidget(
            text: "Select Subject",
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20,),
          CustomDropdown<String>(
            hintText: 'Choose Subject',
            items: diaryP.subjectList,
            onChanged: (category) {
              int index =  diaryP.subjectList.indexOf(category!);
              diaryP.updateSubject(index);
            },
            validateOnChange: true,
            validator: (value){
              if(value ==null){
                return "Select Subject";
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
          _dateView(context),
          const SizedBox(height: 20,),

          AppTextWidget(text: "Note"),
          const SizedBox(height: 10,),
          AppTextField(
            controller: diaryP.titleC,
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

                final _diary = DiaryModel(
                    title: "",
                    description: diaryP.titleC.text,
                    classId: diaryP.selectedClass,
                    subjectId: diaryP.selectedSubject,
                    studentId: "",
                    date: DateTime.now().millisecondsSinceEpoch.toString(),
                    timeStamp: (diaryP.selectedDate ?? DateTime.now()).millisecondsSinceEpoch.toString()
                );

               await diaryP.uploadDiary(_diary);

                AppUtils().showWebToast(text: "Diary Uploaded Successfully");
                ActionProvider.stopLoading(index: 2);

              }
          )

        ],
      ),
    );
  }

  Widget _dateView(BuildContext context){
    return Consumer<DiaryProvider>(
     builder: (context,diaryP, child){
       return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           AppTextWidget(text: "Date"),
           const SizedBox(height: 10,),
           InkWell(
             onTap: () async {
               final DateTime? picked = await showDatePicker(
                 context: context,
                 initialDate: diaryP.selectedDate ?? DateTime.now(),
                 firstDate: DateTime(2000),
                 lastDate: DateTime(2100),
               );
               if (picked != null) {
                 diaryP.updateSelectedDate(picked);
               }
             },
             child: Container(
               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
               decoration: BoxDecoration(
                 color: Colors.grey[200],
                 borderRadius: BorderRadius.circular(8),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   AppTextWidget(
                    text:  diaryP.selectedDate != null
                         ? "${diaryP.selectedDate!.day} ${diaryP.getMonthName(diaryP.selectedDate!.month)} ${diaryP.selectedDate!.year}"
                         : "${DateTime.now().day} ${diaryP.getMonthName(DateTime.now().month)} ${DateTime.now().year}",
                    fontSize: 14,
                   ),
                   const Icon(Icons.calendar_today, size: 20),
                 ],
               ),
             ),
           ),
           const SizedBox(height: 20,),
         ],
       );
     },
    );
  }

  Widget _diaryHistory(){
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
            text: "Diary History",
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20,),
          // const SearchCalenderDropdown(),
          // const SizedBox(height: 20,),
          const DiaryListWidget()
          // StudentExpenseListWidget(formID: model.formId),
        ],
      ),
    );
  }
}
