import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:legends_schools_admin/Model/menu_modal.dart';
import 'package:legends_schools_admin/config/component/dropdpwn_calender.dart';
import 'package:legends_schools_admin/config/enum/form_type.dart';
import 'package:legends_schools_admin/config/keys/db_key.dart';
import 'package:legends_schools_admin/config/res/app_string.dart';
import 'package:legends_schools_admin/config/util/app_utils.dart';
import 'package:legends_schools_admin/model/fee/fee_status_model.dart';
import 'package:legends_schools_admin/provider/constant/action_provider.dart';
import 'package:legends_schools_admin/provider/fee_management_provider.dart';
import 'package:legends_schools_admin/provider/menu/menu_provider.dart';
import 'package:legends_schools_admin/config/util/time_utils.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';

import '../../../config/component/app_text_widget.dart';
import '../../../config/shadcn/search_dropdpwn.dart';
import '../../../config/util/web_utils.dart';
import '../../../constant.dart';
import '../../../model/registration_form_model.dart';
import '../../../provider/registration/registration_provider.dart';
import '../../../provider/stream/stream_data_provider.dart';
import '../../../responsive.dart';

class FeeStatusListWidget extends StatelessWidget {
  const FeeStatusListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    log("message");
    final provider = Provider.of<StreamDataProvider>(context, listen: false);
    final searchProvider = Provider.of<RegistrationProvider>(context);

    return Container(
      color: background,
      margin: EdgeInsets.all(2.w),
      child: Column(
        children: [
          _SearchField(),
          const SizedBox(height: 10.0,),
          StreamBuilder<List<FeeStatusModel>>(
            stream: provider.getMonthlyStudentFeeStatus(),
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
                    "No Pending dues",
                    style: TextStyle(
                      fontSize: Responsive.isMobile(context) ? 12.0 : 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              final admissions = snapshot.data!
                  .where((student) => searchProvider.filterAdmissions(student.students!))
                  .toList()
                ..sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));

              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: PaginatedDataTable(
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextWidget(
                        text: "Fee Month: November 2024",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.start,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          SearchDropDownWidget(
                            options: ActionProvider().months,
                            displayText: (month) => month,
                            onChanged: (selected) {
                              log('Selected: $selected');
                            },
                            onSearchChanged: (value){
                              ActionProvider().updateSearchValue(value);
                            },
                          ),
                        const  SizedBox(width: 20,),
                          SearchDropDownWidget(
                            options: ActionProvider().months,
                            displayText: (month) => month,
                            onChanged: (selected) {
                              log('Selected: $selected');
                            },
                            onSearchChanged: (value){
                              ActionProvider().updateSearchValue(value);
                            },
                          ),
                        ],
                      ),


                    ],
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
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<DataColumn> _buildDataColumns() {
    return [
      DataColumn(label: _buildHeader("Form ID")),
      DataColumn(label: _buildHeader("Name")),
      DataColumn(label: _buildHeader("Father CNIC")),
      DataColumn(label: _buildHeader("Class")),
      DataColumn(label: _buildHeader("Contact#")),
      DataColumn(label: _buildHeader("Fee Status")),
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
  final List<FeeStatusModel> admissions;
  final BuildContext context;

  DataTableSourceImpl({
    required this.admissions,
    required this.context,
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
        DataCell(AppTextWidget(text: student.students!.formId, color: Colors.black)),
        DataCell(_buildStudentNameCell(student.students!)),
        DataCell(AppTextWidget(text: WebUtils().formatCNIC(student.students!.fatherCNIC), color: Colors.black,isSelectable: true,)),
        DataCell(AppTextWidget(text: student.students!.className, color: Colors.black)),
        DataCell(AppTextWidget(text: student.students!.contactNumber, color: Colors.black,isSelectable: true,)),
        DataCell(
            Container(
              width: 80.0,
              height: 30,
              // padding:const EdgeInsets.symmetric(
              //   vertical: 10.0
              // ),
              decoration:  BoxDecoration(
                color:  student.status == "Paid" ? Colors.green : Colors.red,
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
        DataCell(_buildActionCell(context,student.students!)),
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
            isSelectable: true,
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

  Widget _buildActionCell(BuildContext context,RegistrationFormModel student) {
    final provider = Provider.of<RegistrationProvider>(context,listen: false);
    final menuP = Provider.of<MenuProvider>(context,listen: false);
    return Row(
      children: [
        InkWell(
          onTap: () {
            // MenuModel model =  MenuModel(icon: 'assets/svg/profile.svg', title: AppString.newAdmission);
            // provider.updateStudent(student,type: FormType.edit.name);
            // menuP.selectSubItem(model);
          }, // Add edit action here
          child: Icon(Icons.remove_red_eye, color: Colors.black, size: Responsive.isMobile(context) ? 24 : 30),
        ),
        const SizedBox(width: 5),
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
