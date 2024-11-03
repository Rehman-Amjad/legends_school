import 'package:flutter/material.dart';
import '../../config/component/app_text_widget.dart';
import '../../responsive.dart';
import 'component/teacher_register_list_widget.dart';

class TeacherListScreen extends StatelessWidget {
  const TeacherListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 30
          ),
          child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextWidget(
                        text: "Teacher Registration List",
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: Responsive.isMobile(context) ? 14.0 : 18.0),
                    // ButtonWidget(
                    //     text: "Add New",
                    //     width: 120,
                    //     height: 50,
                    //     backgroundColor: primaryColor,
                    //     onClicked: () async{
                    //       // provider.selectIndex(14);
                    //     }
                    // )
                  ],
                ),
                SizedBox(height: 20,),
                TeacherRegisterListWidget(),
              ]
          ),
        )
    );
  }
}
