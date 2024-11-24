import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/component/custom_richtext.dart';
import 'package:legends_schools_admin/config/enum/form_type.dart';
import 'package:legends_schools_admin/config/util/time_utils.dart';
import 'package:legends_schools_admin/config/util/web_utils.dart';
import 'package:legends_schools_admin/model/daily_expense_model.dart';
import 'package:legends_schools_admin/provider/pagination/pagination_provider.dart';
import 'package:provider/provider.dart';

import '../../../../config/component/app_text_widget.dart';
import '../../../../constant.dart';
import '../../../../provider/registration/registration_provider.dart';
import '../../../../provider/stream/stream_data_provider.dart';
import '../../../../responsive.dart';

class StudentExpenseListWidget extends StatelessWidget {
  final UIType type;
  String? status,formID;
  StudentExpenseListWidget({super.key,this.type = UIType.List,this.status,required this.formID});

  @override
  Widget build(BuildContext context) {
    log("message");
    final provider = Provider.of<StreamDataProvider>(context, listen: false);
    final searchProvider = Provider.of<RegistrationProvider>(context);
    final paginationProvider = Provider.of<PaginationProvider>(context, listen: false);
    return Column(
      children: [
        _SearchField(),
        const SizedBox(height: 10.0,),
        StreamBuilder<Map<String, dynamic>>(
          stream: provider.getStudentExpense(month: status, formId: formID ?? "0"),
          builder: (context, snapshot) {
            // Debugging: log snapshot state and data
            log('Snapshot State: ${snapshot.connectionState}');
            log('Snapshot Has Data: ${snapshot.hasData}');
            log('Snapshot Data: ${snapshot.data}');

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
            } else if (snapshot.hasData) {
              final data = snapshot.data;
              if (data != null && data.isNotEmpty) {
                final expenses = data['expenses'] as List<DailyExpenseModel>;
                final totalAmount = data['totalAmount'] as double;

                if (expenses.isEmpty) {
                  return Center(
                    child: Text(
                      "No expense history of this month",
                      style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 12.0 : 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                final filteredExpenses = searchProvider.filterExpenses(expenses);
                final paginatedData = paginationProvider.getPaginatedData(filteredExpenses);

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: CustomRichText(
                            firstText: "Total Amount: ",
                            secondText: WebUtils().formatCurrency(totalAmount),
                            secondWeight: FontWeight.bold,
                          )
                      ),
                    ),
                    _ExpenseTable(expenses: paginatedData),
                    _PaginationControls(totalItems: filteredExpenses.length),
                  ],
                );
              } else {
                return Center(
                  child: Text(
                    "No expense history of this month",
                    style: TextStyle(
                      fontSize: Responsive.isMobile(context) ? 12.0 : 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            } else {
              return Center(
                child: Text(
                  "No expense history of this month",
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 12.0 : 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          },
        )

      ],
    );
  }
}


class _ExpenseTable extends StatelessWidget {
  final List<DailyExpenseModel> expenses;

  const _ExpenseTable({required this.expenses});

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
          1: FractionColumnWidth(0.2),
          2: FractionColumnWidth(0.4),
          3: FractionColumnWidth(0.2),
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
        _buildHeader("Description"),
        _buildHeader("Payment Method"),
      ],
    );
  }

  TableRow _buildTableRow(DailyExpenseModel expense) {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.white),
      children: [
        _buildCell(TimeUtils().formatTimestamp(expense.timeStamp)),
        _buildCell(WebUtils().formatCurrency(expense.amount)),
        _buildCell(expense.description),
        _buildCell(expense.paymentMethod),
        // _buildActionCell(expense)
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

  Widget _buildActionCell(DailyExpenseModel expense) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Add the delete action here
        },
        child: Icon(Icons.delete,color: Colors.red,)),
    );
  }


}

class _PaginationControls extends StatelessWidget {
  final int totalItems;

  const _PaginationControls({required this.totalItems});

  @override
  Widget build(BuildContext context) {
    final paginationProvider = Provider.of<PaginationProvider>(context);

    final totalPages = (totalItems / paginationProvider.itemsPerPage).ceil();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: paginationProvider.currentPage > 1
              ? () => paginationProvider.goToPreviousPage()
              : null,
          icon: const Icon(Icons.chevron_left),
          color: primaryColor,
        ),
        Text(
          "Page ${paginationProvider.currentPage} of $totalPages",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: paginationProvider.currentPage < totalPages
              ? () => paginationProvider.goToNextPage(totalItems)
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
