import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/enum/toast_type.dart';
import 'package:legends_schools_admin/config/keys/db_key.dart';
import 'package:legends_schools_admin/config/util/app_utils.dart';
import 'package:legends_schools_admin/config/util/time_utils.dart';
import 'package:legends_schools_admin/model/diary/diary_model.dart';
import 'package:legends_schools_admin/provider/diary/diary_provider.dart';
import 'package:legends_schools_admin/provider/pagination/pagination_provider.dart';
import 'package:provider/provider.dart';

import '../../../../config/component/app_text_widget.dart';
import '../../../../constant.dart';
import '../../../../provider/registration/registration_provider.dart';
import '../../../config/component/date_range_selector.dart';

class DiaryListWidget extends StatelessWidget {

  final bool isSearch;
  const DiaryListWidget({super.key, this.isSearch = true});

  @override
  Widget build(BuildContext context) {
    log("message");
    return Column(
      children: [
        // if(isSearch)...[
        //   _SearchField(),
        //   const SizedBox(height: 10.0,),
        // ],
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: DateRangeSelector(),
        ),
        Consumer2<DiaryProvider, RegistrationProvider>(
    builder: (context, diaryP, searchProvider, child){
      return StreamBuilder<List<DiaryModel>>(
        stream: diaryP.getDiary(formID: "formID"),
        builder: (context, snapshot) {


          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Diary found'));
          }

          List<DiaryModel> diaries = snapshot.data!;

          // final filteredExpenses = searchProvider.filterDiary(diaries);
          final searchFiltered = searchProvider.filterDiary(diaries);
          final dateFiltered = diaryP.filterDiaryByDate(searchFiltered);

          return Consumer<PaginationProvider>(
            builder: (context, provider, child){
              final paginatedData = provider.getDiaryData(dateFiltered);
              return Column(
                children: [
                  _ExpenseTable(expenses: paginatedData),
                  _PaginationControls(totalItems: dateFiltered.length),
                ],
              );
            },
          );
        },
      );
    }
        )

      ],
    );
  }
}


class _ExpenseTable extends StatelessWidget {
  final List<DiaryModel> expenses;

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
          1: FractionColumnWidth(0.1),
          2: FractionColumnWidth(0.4),
          3: FractionColumnWidth(0.2),
          4: FractionColumnWidth(0.1),
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
        _buildHeader("Class"),
        _buildHeader("Subject"),
        _buildHeader("Description"),
        _buildHeader("Action"),
      ],
    );
  }

  TableRow _buildTableRow(DiaryModel expense) {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.white),
      children: [
        _buildCell(TimeUtils().formatTimestamp(expense.date)),
        _buildCell(expense.classId),
        _buildCell(expense.subjectId),
        _buildCell(expense.description),
        _buildActionCell(expense)
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

  Widget _buildActionCell(DiaryModel diary) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          onTap: () async{
            // Add the delete action here
            await  FirebaseFirestore.instance.collection(DbKey.studentDiary)
                .doc(diary.date).delete();

            // final ExpenseService expenseService = ExpenseService();

            // await expenseService.deleteExpense(formID, expense.monthYear, expense.amount);
            AppUtils().showWebToast(
                text: "Diary deleted",
                toastType: ToastType.success
            );

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
