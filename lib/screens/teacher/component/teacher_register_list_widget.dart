import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:legends_schools_admin/provider/registration/teacher_registration_provider.dart';
import 'package:provider/provider.dart';

import '../../../config/component/app_text_widget.dart';
import '../../../constant.dart';
import '../../../model/teacher_model.dart';
import '../../../provider/registration/registration_provider.dart';
import '../../../provider/stream/stream_data_provider.dart';
import '../../../responsive.dart';

class TeacherRegisterListWidget extends StatelessWidget {
  const TeacherRegisterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    log("message");
    final provider = Provider.of<StreamDataProvider>(context, listen: false);
    final searchProvider = Provider.of<TeacherRegistrationProvider>(context);

    return Column(
      children: [
        _SearchField(),
        SizedBox(height: 10.0,),
        StreamBuilder<List<TeacherModel>>(
          stream: provider.getTeachers(),
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
                  "No admission found",
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 12.0 : 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            final admissions = snapshot.data!
                .where((teachers) => searchProvider.filterTeachers(teachers))
                .toList();
              // ..sort((a, b) => int.parse(a.studentFormID).compareTo(int.parse(b.studentFormID)));

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
                rowsPerPage: admissions.isEmpty ? 1 : (admissions.length > 10 ? 10 : admissions.length),
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
    );
  }

  List<DataColumn> _buildDataColumns() {
    return [
      DataColumn(label: _buildHeader("Registration No")),
      DataColumn(label: _buildHeader("Name")),
      DataColumn(label: _buildHeader("Subject")),
      DataColumn(label: _buildHeader("Class")),
      DataColumn(label: _buildHeader("Contact#")),
      DataColumn(label: _buildHeader("Address")),
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
  final List<TeacherModel> admissions;
  final BuildContext context;

  DataTableSourceImpl({
    required this.admissions,
    required this.context,
  });

  @override
  DataRow? getRow(int index) {
    final teachers = admissions[index];
    return DataRow.byIndex(
      index: index,
      color: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) => Colors.white,
      ),
      cells: [
        DataCell(AppTextWidget(text: teachers.teacherCNIC, color: Colors.black)),
        DataCell(_buildStudentNameCell(teachers)),
        DataCell(AppTextWidget(text: teachers.teacherSubject, color: Colors.black)),
        DataCell(AppTextWidget(text: teachers.teacherClass, color: Colors.black)),
        DataCell(AppTextWidget(text: teachers.teacherContact, color: Colors.black)),
        DataCell(AppTextWidget(text: teachers.address, color: Colors.black)),
        DataCell(_buildActionCell(context)),
      ],
    );
  }

  Widget _buildStudentNameCell(TeacherModel teachers) {
    return Row(
      children: [
        _buildStudentAvatar(teachers.teacherImage),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: AppTextWidget(
            text: teachers.teacherName,
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

  Widget _buildActionCell(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {}, // Add edit action here
          child: Icon(Icons.edit, color: Colors.black, size: Responsive.isMobile(context) ? 24 : 30),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {}, // Add delete action here
          child: Icon(Icons.delete, color: Colors.red, size: Responsive.isMobile(context) ? 24 : 30),
        ),
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
    final searchProvider = Provider.of<TeacherRegistrationProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: (value) => searchProvider.updateSearchTerm(value.toUpperCase()),
        decoration: InputDecoration(
          labelText: "Search by Father CNIC, Form ID, or Class",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
