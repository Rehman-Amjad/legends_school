import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/component/app_text_widget.dart';
import 'package:legends_schools_admin/model/student_model.dart';
import 'package:legends_schools_admin/provider/stream/stream_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../constant.dart';
import '../../../responsive.dart';

class StudentAdmissionListWidget extends StatelessWidget {
  const StudentAdmissionListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StreamDataProvider>(context, listen: false);

    return Column(
      children: [
        StreamBuilder<List<StudentModel>>(
          stream: provider.getAdmissions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: secondaryColor,
                ),
                child: Center(
                  child: Text(
                    "No admission Found",
                    style: TextStyle(
                      fontSize: Responsive.isMobile(context) ? 12.0 : 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }

            final admissions = snapshot.data!;

            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              child: PaginatedDataTable(
                header: AppTextWidget(
                  text: "Total Admissions: ${admissions.length}",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                  color: primaryColor,
                ),
                headingRowColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                    return primaryColor; // Default color
                  },
                ),
                columnSpacing: 20.0,
                arrowHeadColor: primaryColor,
                rowsPerPage: admissions.length > 10 ? 10 : admissions.length,
                columns: [
                  ..._buildDataColumns(),
                ],
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
      DataColumn(
        label: AppTextWidget(
          text: "Admission No",
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      DataColumn(
        label: AppTextWidget(
          text: "Name",
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      DataColumn(
        label: AppTextWidget(
          text: "Father Name",
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      DataColumn(
        label: AppTextWidget(
          text: "Class",
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      DataColumn(
        label: AppTextWidget(
          text: "Contact#",
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      DataColumn(
        label: AppTextWidget(
          text: "Address",
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      DataColumn(
        label: AppTextWidget(
          text: "Action",
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];
  }
}

class DataTableSourceImpl extends DataTableSource {
  final List<StudentModel> admissions;
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
            (Set<WidgetState> states) {
          return Colors.white; // Default color
        },
      ),
      cells: [
        DataCell(
          AppTextWidget(
            text: student.admissionID, // Assuming admissionID is the code
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        DataCell(Row(
          children: [
            Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.only(left: 2, top: 5, bottom: 10),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: student.pdfImageUrl.isNotEmpty ?
                  Image.network(student.pdfImageUrl) :
                  const Center(child: Icon(Icons.person,color: Colors.white,))),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 5.0, bottom: 5.0, top: 5.0),
              child: AppTextWidget(
                text: student.studentName, // Name of the student
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ],
        )),
        DataCell(
          AppTextWidget(
            text: student.fatherName, // Description based on your model
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        DataCell(
          AppTextWidget(
            text: student.studentClassName,
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        DataCell(
          AppTextWidget(
            text: student.contactNumber,
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        DataCell(
          AppTextWidget(
            text: student.studentAddress,
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        DataCell(Row(
          children: [
            InkWell(
              onTap: () {
                // Implement edit functionality
              },
              child: Icon(
                Icons.edit,
                color: primaryColor,
                size: Responsive.isMobile(context) ? 24 : 30,
              ),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: () {
                // Implement delete functionality
              },
              child: Icon(
                Icons.delete,
                color: Colors.red,
                size: Responsive.isMobile(context) ? 24 : 30,
              ),
            ),
          ],
        )),
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
