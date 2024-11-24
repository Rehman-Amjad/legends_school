import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_schools_admin/config/component/app_text_field.dart';
import 'package:legends_schools_admin/config/component/button_widget.dart';
import 'package:legends_schools_admin/config/extenstion/extenstion.dart';
import 'package:legends_schools_admin/config/util/app_utils.dart';
import 'package:legends_schools_admin/routes/routes_name.dart';

import '../../config/res/app_assets.dart';
import '../../config/color/my_color.dart';
import '../../config/util/web_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserValues();
  }

  String? username,password;
  final collectRef = FirebaseFirestore.instance.collection("AdminAccess");
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var fullWidth = MediaQuery.sizeOf(context).width;
    var fullHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 5,
              child: Container(
                color: Colors.blueAccent.shade100,
                child: Stack(
                    children: [

                      SizedBox(
                          width:fullWidth,
                          height: fullHeight,
                          child: Image.asset(AppAssets.loginSideImagePath,fit: BoxFit.fill,opacity: const AlwaysStoppedAnimation(.5),)),

                      Center(
                        child: Text("Legend Schools and Colleges",style: TextStyle(color: AppColor().whiteColor,fontSize: 30,fontWeight: FontWeight.bold),
                        ),
                      )
                    ]
                ),
              )),

          Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset(AppAssets.logo,fit: BoxFit.fill,),
                    ),


                    const SizedBox(height: 20,),
                    Text("Login Now",style: TextStyle(fontSize: 22,color: AppColor().mainColor,fontWeight: FontWeight.bold),),
                   const  SizedBox(height: 20,),

                    Container(
                      width: fullWidth,
                      height: 50,
                      margin: const EdgeInsets.only(left: 50,right: 50),
                      child: AppTextField(
                          controller: usernameController,
                          hintText: "Email"
                      ),
                    ),
                    10.ph,
                    Container(
                        width: fullWidth,
                        height: 50,
                        margin: const EdgeInsets.only(left: 50,right: 50),
                        child: AppTextField(
                            controller: passwordController,
                            hintText: "password"
                        )
                    ),

                    const SizedBox(height: 20,),


                    ButtonWidget(
                        width: 200,
                        text: "Login Now", onClicked: () async{
                      log("${username!}controller: ${usernameController.text}");
                      if(username == usernameController.text.toString().toLowerCase())
                      {
                        if(password == passwordController.text.toString().toLowerCase())
                        {
                          AppUtils().showWebToast(
                            text: "Login Successful"
                          );
                          Get.offAllNamed(RoutesName.drawerScreen);

                        }
                        else{
                          WebUtils().errorToast("invalid password");
                        }
                      }else{
                        WebUtils().errorToast("invalid username");
                      }
                    }),

                  ],
                ),
              ))
        ],
      ),
    );
  }

  void getUserValues() {
    collectRef.doc("admindetails").get().then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        username = snapshot.get("username");
        password = snapshot.get("password");
      }
    });
  }
}

