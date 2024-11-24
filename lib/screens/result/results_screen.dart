import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/res/app_assets.dart';
import 'package:legends_schools_admin/model/fee.dart';
import 'package:legends_schools_admin/provider/fee_management_provider.dart';
import 'package:provider/provider.dart';
import '../../config/component/app_text_widget.dart';
import '../../config/component/button_widget.dart';
import '../../constant.dart';
import '../../provider/constant/action_provider.dart';
import '../../provider/constant/result_provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resultProvider = Provider.of<ResultProvider>(context);
    final feeP = Provider.of<FeeManagementProvider>(context);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            // Left section for form input
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   const SizedBox(height: 20),
                    Image.asset(AppAssets.logo, height: 150),
                    const SizedBox(height: 20),
                   const Text("Add School Results", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    _buildTextField("Student Name", resultProvider.studentNameController),
                    _buildTextField("Class Name", resultProvider.studentClassController),
                    _buildTextField("Session", resultProvider.studentSessionController, TextInputType.number),
                    _buildDropdown(resultProvider),
                    _buildTextField("Roll No", resultProvider.studentRollNoController, TextInputType.number),
                    _buildTextField("Obtained Marks", resultProvider.studentObtMarksController, TextInputType.number),
                    _buildTextField("Total Marks", resultProvider.studentTotalMarksController, TextInputType.number),
                   const SizedBox(height: 10),

                    ButtonWidget(
                      isIcon: false,
                      width: 200,
                      text: "Upload",
                      onClicked: () async{
                        ActionProvider.startLoading();
                        resultProvider.saveResult();

                        // final fee = Fee(
                        //     amount: 1500,
                        //     paidAmount: 0,
                        //     status: "Unpaid",
                        //     paidDate: DateTime(2024,10,2),
                        //     pendingDues: 0,
                        //     previousMonthDues: 0,
                        //     lateFee: 0,
                        //     scholarshipDiscount: 0
                        // );
                        //
                        //
                        // feeP.addFeeAndUpdateMonthlyStatus(
                        //     "2",
                        //     fee,
                        //     "2024-10"
                        // );
                      }
                    )
                  ],
                ),
              ),
            ),
            // Right section for results table
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(child: _buildResultsTable(resultProvider)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  Widget _buildDropdown(ResultProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField(
        value: provider.selectedGender,
        items: provider.genderList.map((gender) {
          return DropdownMenuItem(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
        onChanged: (value) => provider.setSelectedGender(value),
        decoration: InputDecoration(
          labelText: "Select Gender",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  Widget _buildResultsTable(ResultProvider provider) {
    return StreamBuilder<QuerySnapshot>(
      stream: provider.resultsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.blueAccent));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No Results Found", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          );
        }

        return Table(
          border: TableBorder.all(color: Colors.black, width: 0.5),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(2),
            4: FlexColumnWidth(2),
            5: FlexColumnWidth(2),
            6: FlexColumnWidth(2),
          },
          children: [
            _buildTableHeader(),
            ...snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return TableRow(
                children: [
                  _buildTableCell(data['rollNo']),
                  _buildTableCell(data['name']),
                  _buildTableCell(data['className']),
                  _buildTableCell(data['gender']),
                  _buildTableCell(data['session']),
                  _buildTableCell(data['obt']),
                  Center(
                    child: InkWell(
                      onTap: () => provider.deleteResult(data['id']),
                      child: const Icon(Icons.delete,color: Colors.red,),
                    ),
                  )
                ],
              );
            }),
          ],
        );
      },
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      children: [
        _buildHeaderCell("Roll No"),
        _buildHeaderCell("Name"),
        _buildHeaderCell("Class"),
        _buildHeaderCell("Gender"),
        _buildHeaderCell("Session"),
        _buildHeaderCell("Obt Marks"),
        _buildHeaderCell("Action"),
      ],
    );
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      color: primaryColor,
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Text(
          text, style:const TextStyle(
        fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: 
      AppTextWidget(text: text,fontSize: 16,)
      ),
    );
  }
}
