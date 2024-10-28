
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

const primaryColorCode = 0xFFA9DFD8;
const cardBackgroundColor = Color(0xff044C92);
const primaryColor = Color(0xff044C92);
const secondaryColor = Color(0xff044C92);
const lightPurpleColor = Color(0xffB1AFE9);
const dimPurpleColor = Color(0xffE9E8FF);
const lightOrange = Color(0xffFFF0EC);
const bgOrange = Color(0xffFFEDE5);
const whiteColor = Color(0xFFFFFFFF);
const bgColor = Color(0xFFFFF0EC);
const lightGrey = Color(0xFFE2E8F0);
const midLightGrey = Color(0xFFF7F8F8);
const darkPurple = Color(0xFF171433);
const darkGrey = Color(0x89534F5D);
const lightBlue = Colors.lightBlue;
const Color customGrey = Color(0xFFFBFAF8);

var firestore = FirebaseFirestore.instance;
var storage = FirebaseStorage.instance;