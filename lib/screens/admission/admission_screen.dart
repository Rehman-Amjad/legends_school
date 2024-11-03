import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/component/app_text_widget.dart';
import 'package:legends_schools_admin/config/keys/menu_screen_keys.dart';
import 'package:legends_schools_admin/constant.dart';
import 'package:legends_schools_admin/provider/global/global_access_provider.dart';
import 'package:legends_schools_admin/provider/menu/menu_provider.dart';
import 'package:legends_schools_admin/screens/admission/view/student_admission_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../config/component/button_widget.dart';
import '../../responsive.dart';

class AdmissionScreen extends StatelessWidget {
  const AdmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
            vertical: 3.w
          ),
          child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextWidget(
                        text: "Student Admission List",
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: Responsive.isMobile(context) ? 14.0 : 18.0),
                  ],
                ),
                SizedBox(height: 2.w,),
                const StudentAdmissionListWidget(),
              ]
          ),
        )
    );
  }
}
