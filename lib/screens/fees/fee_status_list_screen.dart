import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/component/app_text_widget.dart';
import 'package:legends_schools_admin/config/component/custom_card.dart';
import 'package:legends_schools_admin/constant.dart';
import 'package:legends_schools_admin/model/fee/fee_status_model.dart';
import 'package:legends_schools_admin/provider/fee_management_provider.dart';
import 'package:legends_schools_admin/provider/stream/stream_data_provider.dart';
import 'package:legends_schools_admin/screens/fees/view/fee_status_list_widget.dart';
import 'package:provider/provider.dart';

import '../../config/component/activity_details_card.dart';
import '../../config/util/web_utils.dart';

class FeeStatusListScreen extends StatelessWidget {

  FeeStatusListScreen();

  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeManagementProvider>(context,listen: false);

    Future.microtask(() async{
      await feeProvider.fetchTotalFees();
    });
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const  SizedBox(height: 20,),
            Consumer<FeeManagementProvider>(
             builder: (context, provider, child){
               return Container(
                 margin: const EdgeInsets.symmetric(horizontal: 40),
                 child: Row(
                   children: [
                     _infoBox(title: "Total Amount: ${WebUtils().formatCurrency(double.parse(provider.totalAmount))}"),
                     const SizedBox(width: 30,),
                     _infoBox(title: "Fee Paid: ${WebUtils().formatCurrency(double.parse(provider.totalAmountPaid))}"),
                     const SizedBox(width: 30,),
                     _infoBox(title: "Fee Pending: ${WebUtils().formatCurrency(double.parse(provider.totalAmountRemaining))}"),

                   ],
                 ),
               );
             },
            ),
          const FeeStatusListWidget()
          ],
        ),
      ),
    );
  }

  Widget _infoBox({required String title}){
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10
        ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.wallet,color: Colors.black,),
              const  SizedBox(width: 5,),
              AppTextWidget(
               text:  title,
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
      
            ],
          )
      ),
    );
  }
  
}
