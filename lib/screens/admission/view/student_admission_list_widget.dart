import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:legends_schools_admin/Model/menu_modal.dart';
import 'package:legends_schools_admin/config/enum/form_type.dart';
import 'package:legends_schools_admin/config/res/app_string.dart';
import 'package:legends_schools_admin/provider/constant/picker_provider.dart';
import 'package:legends_schools_admin/provider/menu/menu_provider.dart';
import 'package:legends_schools_admin/routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../../../config/component/app_text_widget.dart';
import '../../../constant.dart';
import '../../../model/registration_form_model.dart';
import '../../../provider/registration/registration_provider.dart';
import '../../../provider/stream/stream_data_provider.dart';
import '../../../responsive.dart';

class StudentAdmissionListWidget extends StatelessWidget {
  final UIType type;
  String? status;
   StudentAdmissionListWidget({super.key,this.type = UIType.List,this.status});

  @override
  Widget build(BuildContext context) {
    log("message");
    final provider = Provider.of<StreamDataProvider>(context, listen: false);
    final searchProvider = Provider.of<RegistrationProvider>(context);

    return Column(
      children: [
        _SearchField(),
       const SizedBox(height: 10.0,),
        StreamBuilder<List<RegistrationFormModel>>(
          stream: provider.getAdmissions(status: status),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "No student found",
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 12.0 : 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            final admissions = snapshot.data!
                .where((student) => searchProvider.filterAdmissions(student))
                .toList()
              ..sort((a, b) => int.parse(a.formId).compareTo(int.parse(b.formId)));

            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: PaginatedDataTable(
                header: AppTextWidget(
                  text: "Total Admissions: ${admissions.length}",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                  color: Colors.black,
                ),
                headingRowColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) => primaryColor,
                ),
                columnSpacing: 20.0,
                arrowHeadColor: primaryColor,
                rowsPerPage: admissions.isEmpty ? 1 : (admissions.length > 15 ? 15 : admissions.length),
                columns: _buildDataColumns(),
                source: DataTableSourceImpl(
                  admissions: admissions,
                  context: context,
                  type: type
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  List<DataColumn> _buildDataColumns() {
    return [
      DataColumn(label: _buildHeader("Admission No")),
      DataColumn(label: _buildHeader("Name")),
      DataColumn(label: _buildHeader("Father Name")),
      DataColumn(label: _buildHeader("Class")),
      DataColumn(label: _buildHeader("Contact#")),
      // DataColumn(label: _buildHeader("Address")),
      if(UIType.Expense != type)
      DataColumn(label: _buildHeader("Status")),
      DataColumn(label: _buildHeader("Action")),
    ];
  }

  Widget _buildHeader(String text) {
    return AppTextWidget(
      text: text,
      color: Colors.white,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    );
  }
}

// DataTableSource implementation
class DataTableSourceImpl extends DataTableSource {
  final List<RegistrationFormModel> admissions;
  final BuildContext context;
  final UIType type;

  DataTableSourceImpl({
    required this.admissions,
    required this.context,
    required this.type,
  });

  @override
  DataRow? getRow(int index) {
    final student = admissions[index];
    return DataRow.byIndex(
      index: index,
      color: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) => Colors.white,
      ),
      cells: [
        DataCell(AppTextWidget(text: student.formId, color: Colors.black)),
        DataCell(_buildStudentNameCell(student)),
        DataCell(AppTextWidget(text: student.fatherName, color: Colors.black)),
        DataCell(AppTextWidget(text: student.className, color: Colors.black)),
        DataCell(AppTextWidget(text: student.contactNumber, color: Colors.black)),
        // DataCell(AppTextWidget(text: student.address, color: Colors.black)),
        if(UIType.Expense != type)
        DataCell(
            Container(
              width: 80.0,
              height: 30,
              decoration:  BoxDecoration(
                color:  student.status == "ACTIVE" ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: AppTextWidget(
                  fontSize: 11,
                text: student.status,
                color:Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
              ),
            )),
        DataCell(_buildActionCell(context,student,type)),
      ],
    );
  }

  Widget _buildStudentNameCell(RegistrationFormModel student) {
    return Row(
      children: [
        _buildStudentAvatar(student.pdfImageUrl),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: AppTextWidget(
            text: student.name,
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }

  Widget _buildStudentAvatar(String imageUrl) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: imageUrl.isNotEmpty
            ? Image.network(imageUrl,fit: BoxFit.cover,)
            : const Icon(Icons.person, color: Colors.white),
      ),
    );
  }

  Widget _buildActionCell(BuildContext context,RegistrationFormModel student,UIType type) {
    final provider = Provider.of<RegistrationProvider>(context,listen: false);
    final menuP = Provider.of<MenuProvider>(context,listen: false);
    final pickP = Provider.of<PickerProvider>(context,listen: false);
    return Row(
      children: [
        if(UIType.List == type)
        InkWell(
          onTap: () {
            MenuModel model =  MenuModel(icon: 'assets/svg/profile.svg', title: AppString.newAdmission);
            pickP.clear();
            provider.resetAllControllers();
            provider.updateStudent(student,type: FormType.edit.name);
            menuP.selectSubItem(model);
          }, // Add edit action here
          child: Icon(Icons.remove_red_eye, color: Colors.grey, size: Responsive.isMobile(context) ? 24 : 25),
        ),
        if(UIType.Expense == type)
        InkWell(
          onTap: () {
            // MenuModel model =  MenuModel(icon: 'assets/svg/profile.svg', title: AppString.newAdmission);
            // pickP.clear();
            // provider.resetAllControllers();
            provider.updateStudent(student,type: FormType.view.name);
            Get.toNamed(RoutesName.addStudentExpenseScreen);
            // Get.toNamed();
            // menuP.selectSubItem(model);
          }, // Add edit action here
          child: Row(
            children: [
              Container(
                width: 80.0,
                height: 30,
                decoration:  BoxDecoration(
                  color:  Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: AppTextWidget(
                    fontSize: 11,
                    text: "Add Expense",
                    color:Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Icon(Icons.remove_red_eye, color: Colors.grey, size: Responsive.isMobile(context) ? 24 : 25),
            ],
          ),
        ),
        const SizedBox(width: 5),
        // InkWell(
        //   onTap: () async{
        //
        //     AppUtils().webAlertDialog(
        //       rightPress: () async{
        //         Navigator.of(context).pop();
        //         await firestore.collection(DbKey.admissions).doc(student.formId).delete();
        //         AppUtils().showWebToast(text: "Student Deleted");
        //       }
        //     );
        //
        //   }, // Add delete action here
        //   child: Icon(Icons.remove_red_eye, color: Colors.grey, size: Responsive.isMobile(context) ? 24 : 30),
        // ),
      ],
    );
  }

  @override
  int get rowCount => admissions.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}


// Search Field Widget
class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<RegistrationProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: (value) => searchProvider.updateSearchTerm(value.toLowerCase()),
        decoration: InputDecoration(
          labelText: "Search by CNIC, Name, or Class",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
