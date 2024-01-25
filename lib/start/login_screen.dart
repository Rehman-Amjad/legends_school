import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_schools_admin/helper/image_path.dart';
import 'package:legends_schools_admin/helper/my_color.dart';
import 'package:legends_schools_admin/helper/my_input_field.dart';
import 'package:legends_schools_admin/helper/my_toast.dart';
import 'package:legends_schools_admin/helper/text_helper.dart';

import 'dashboard_screen.dart';

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
    var _FULL_WIDTH = MediaQuery.sizeOf(context).width;
    var _FULL_HEIGHT = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 5,
              child: Container(
                color: Colors.blueAccent.shade100,
                child: Stack(
                    children: [

                      Container(
                          width:_FULL_WIDTH,
                          height: _FULL_HEIGHT,
                          child: Image.asset(ImagePath().loginSideImagePath,fit: BoxFit.fill,opacity: const AlwaysStoppedAnimation(.5),)),

                      Center(
                        child: Text("Legend Schools and Colleges",style: TextStyle(color: MyColor().whiteColor,fontSize: 30,fontWeight: FontWeight.bold),
                        ),
                      )
                    ]
                ),
              )),

          Expanded(
              flex: 3,
              child: Container(
                color: Colors.grey.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.asset(ImagePath().logoImagePath,fit: BoxFit.fill,),
                    ),


                    SizedBox(height: 20,),
                    Text("Login Now",style: TextStyle(fontSize: 22,color: MyColor().mainColor,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),

                    Container(
                      width: _FULL_WIDTH,
                      height: 50,
                      margin: EdgeInsets.only(left: 50,right: 50),
                      child: MyCustomInputField(
                        "Username","Usernmae",usernameController
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: _FULL_WIDTH,
                      height: 50,
                      margin: EdgeInsets.only(left: 50,right: 50),
                      child: MyCustomInputField(
                          "Password","Password",passwordController
                      ),
                    ),

                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){

                        print(username! + "controller: " + usernameController.text.toString());
                        if(username == usernameController.text.toString().toLowerCase())
                          {
                            if(password == passwordController.text.toString().toLowerCase())
                              {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashBoardScreen()));
                              }
                            else{
                              MyToast().errorToast("invalid password");
                            }
                          }else{
                          MyToast().errorToast("invalid username");
                        }

                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        child: const Center(child: Text("Login Now",style: TextStyle(color: Colors.white),)),
                        decoration: BoxDecoration(
                            color: MyColor().mainColor,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    )


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
