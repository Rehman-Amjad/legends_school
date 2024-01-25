import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:legends_schools_admin/helper/image_path.dart';
import 'package:legends_schools_admin/start/login_screen.dart';


class StartScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _StartScreenState();

}

class _StartScreenState extends State<StartScreen>{

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4),(){

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

    });

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: AnimatedContainer(
              padding: EdgeInsets.all(10.0),
              width: 200,
              height: 200,
              curve: Curves.easeIn,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(21)),
              ),
              duration: Duration(seconds: 4),
              child: Image.asset(ImagePath().logoImagePath),
            ),
          ),
        )
    );
  }

}