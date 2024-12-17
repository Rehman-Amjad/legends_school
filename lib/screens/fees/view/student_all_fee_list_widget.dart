import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/component/custom_richtext.dart';
import 'package:legends_schools_admin/config/enum/form_type.dart';
import 'package:legends_schools_admin/config/enum/toast_type.dart';
import 'package:legends_schools_admin/config/keys/db_key.dart';
import 'package:legends_schools_admin/config/util/app_utils.dart';
import 'package:legends_schools_admin/config/util/time_utils.dart';
import 'package:legends_schools_admin/config/util/web_utils.dart';
import 'package:legends_schools_admin/model/daily_expense_model.dart';
import 'package:legends_schools_admin/model/fee/student_fee_model.dart';
import 'package:legends_schools_admin/provider/pagination/pagination_provider.dart';
import 'package:provider/provider.dart';

import '../../../../config/component/app_text_widget.dart';
import '../../../../constant.dart';
import '../../../../provider/registration/registration_provider.dart';
import '../../../../provider/stream/stream_data_provider.dart';
import '../../../../responsive.dart';
import '../../../model/fee.dart';

class StudentAllFeeListWidget extends StatelessWidget {
  final UIType type;
  String? status,formID;
  StudentAllFeeListWidget({super.key,this.type = UIType.List,this.status,required this.formID});

  @override
  Widget build(BuildContext context) {
    log("message");
    final provider = Provider.of<StreamDataProvider>(context, listen: false);
    return Column(
      children: [
        StreamBuilder<List<StudentFeeModel>>(
          stream: provider.getSingleStudentFee(formID: formID ?? "0"),
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
                  "No fee record found",
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 12.0 : 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            List<StudentFeeModel> admissions = snapshot.data!;

            return Consumer<PaginationProvider>(
              builder: (context, provider, child){
                final paginatedData = provider.getSingleStudentPaginatedData(admissions);
                return Column(
                  children: [
                    _ExpenseTable(expenses: paginatedData,formID: formID ?? "0",),
                    _PaginationControls(totalItems: paginatedData.length),
                  ],
                );
              },
            );
          },
        )

      ],
    );
  }
}


class _ExpenseTable extends StatelessWidget {
  final List<StudentFeeModel> expenses;
  final String formID;

  const _ExpenseTable({required this.expenses, required this.formID});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Table(
        border: TableBorder.all(color: primaryColor),
        columnWidths: const {
          0: FractionColumnWidth(0.2),
          1: FractionColumnWidth(0.1),
          2: FractionColumnWidth(0.1),
          3: FractionColumnWidth(0.1),
          4: FractionColumnWidth(0.1),
          5: FractionColumnWidth(0.1),
          6: FractionColumnWidth(0.1),
          // 4: FractionColumnWidth(0.2)
        },
        children: [
          _buildTableHeader(),
          ...expenses.map(_buildTableRow),
        ],
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: const BoxDecoration(color: primaryColor),
      children: [
        _buildHeader("Date"),
        _buildHeader("Amount"),
        _buildHeader("Late Fee"),
        _buildHeader("Daily Expense"),
        _buildHeader("Paid Amount"),
        _buildHeader("Pending Dues"),
        _buildHeader("Status"),
      ],
    );
  }

  TableRow _buildTableRow(StudentFeeModel fees) {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.white),
      children: [
        _buildCell(fees.monthYear.toString()),
        _buildCell(WebUtils().formatCurrency(fees.amount)),
        _buildCell(WebUtils().formatCurrency(fees.lateFee)),
        _buildCell(WebUtils().formatCurrency(fees.dailyExpense)),
        _buildCell(WebUtils().formatCurrency(fees.paidAmount)),
        _buildCell(WebUtils().formatCurrency(fees.pendingDues)),
        _buildCell(fees.status.toString()),
      ],
    );
  }

  Widget _buildCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppTextWidget(text: text, color: Colors.black),
    );
  }

  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppTextWidget(
        text: text,
        color: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }



}

class _PaginationControls extends StatelessWidget {
  final int totalItems;

  const _PaginationControls({required this.totalItems});

  @override
  Widget build(BuildContext context) {
    final paginationProvider = Provider.of<PaginationProvider>(context);

    final totalPages = (totalItems / paginationProvider.itemsSingleStudentPerPage).ceil();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: paginationProvider.singleStudentPage > 1
              ? () => paginationProvider.singleStudentPreviousPage()
              : null,
          icon: const Icon(Icons.chevron_left),
          color: primaryColor,
        ),
        Text(
          "Page ${paginationProvider.singleStudentPage} of $totalPages",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: paginationProvider.singleStudentPage < totalPages
              ? () => paginationProvider.singleStudentNextPage(totalItems)
              : null,
          icon: const Icon(Icons.chevron_right),
          color: primaryColor,
        ),
      ],
    );
  }
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
          labelText: "Search by Category",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
