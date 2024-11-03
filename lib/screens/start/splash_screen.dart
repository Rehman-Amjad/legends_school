import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:legends_schools_admin/screens/start/login_screen.dart';

import '../../config/res/app_assets.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
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
          padding: const EdgeInsets.all(10.0),
          width: 200,
          height: 200,
          curve: Curves.easeIn,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(21)),
          ),
          duration: const Duration(seconds: 4),
          child: Image.asset(AppAssets.logo),
        ),
      ),
    ));
  }
}
