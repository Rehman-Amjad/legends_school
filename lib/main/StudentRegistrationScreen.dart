
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:html';

import 'package:legends_schools_admin/controller/image_controller.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// }

class StudentRegistrationScreen extends StatefulWidget {
  @override
  State<StudentRegistrationScreen> createState() =>
      _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserValues();
  }

  _StudentRegistrationScreenState() {
    selectedGroup = groupArrayList[0];
    selectClass = classArrayList[0];
    academyStatus = academyStatusArrayList[0];
    feeStatus = feeStatusArrayList[0];
    selectedGender = genderArrayList[0];
    selectedSubjectPrice = subjectPriceArrayList[0];
    selectedSubjectPrice2 = subjectPriceArrayList[0];
    selectedSubjectPrice3 = subjectPriceArrayList[0];
    selectedSubjectPrice4 = subjectPriceArrayList[0];
    selectedSubjectPrice5 = subjectPriceArrayList[0];
    selectedSubjectPrice6 = subjectPriceArrayList[0];
    selectedSubjectPrice7 = subjectPriceArrayList[0];
    selectedSubjectPrice8 = subjectPriceArrayList[0];
    selectedSubjectPrice9 = subjectPriceArrayList[0];

    subject1 = subjectArrayList[0];
    subject2 = subjectArrayList[0];
    subject3 = subjectArrayList[0];
    subject4 = subjectArrayList[0];
    subject5 = subjectArrayList[0];
    subject6 = subjectArrayList[0];
    subject7 = subjectArrayList[0];
    subject8 = subjectArrayList[0];
    subject9 = subjectArrayList[0];
  }

  void clickFunctionTotalDues() {
    setState(() {
      totalDues = (int.parse(dailyTestController.text) +
              int.parse(servicesChargesController.text) +
              int.parse(extraChargesController.text) +
              int.parse(selectedSubjectPrice) +
              int.parse(selectedSubjectPrice2) +
              int.parse(selectedSubjectPrice3) +
              int.parse(selectedSubjectPrice4) +
              int.parse(selectedSubjectPrice5) +
              int.parse(selectedSubjectPrice6) +
              int.parse(selectedSubjectPrice7) +
              int.parse(selectedSubjectPrice8) +
              int.parse(selectedSubjectPrice9)) -
          int.parse(discountController.text);
    });
  }

  FirebaseFirestore firestoredatabase = FirebaseFirestore.instance;

  final classArrayList = [
    'P.G',
    " K.G-I",
    " K.G-II",
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
    "1st Year",
    "2nd Year",
    "B.A",
    "B.Com",
    "Supplementary",
    "Advanced",
    "LAT TEST",
    "GAT TEST",
    "HOME ECONOMICS"
  ];
  final academyStatusArrayList = [
    "ONLINE",
    "ONLINE TUTOR",
    "HOME TUTOR",
    "Academy"
  ];

  final groupArrayList = [
    "Non Group Class",
    "Bio-Science",
    "Arts",
    "Comp-Science",
    "FSC-M",
    "FSC-E",
    "ICS",
    "I.COM",
    "F.A-IT",
    "F.A",
    "PART-I",
    "PART-II"
  ];

  final subjectArrayList = [
    "None",
    "All Subject",
    "Science",
    "Math",
    "English",
    "Urdu",
    "Pak Study",
    "I.S",
    "Al.Quran",
    "Physics",
    "Chemistry",
    "Biology",
    "Computer",
    "IS-Elective",
    "Education",
    "PH-Education",
    "Sociology",
    "Parsion",
    "Arabic",
    "Civics",
    "Statistics",
    "Economics",
    "Commerce",
    "Banking",
    "Accounting",
    "Geo Graphic",
    "Home Economics",
    "Punjabi",
    "Other"
  ];

  final subjectPriceArrayList = [
    "0",
    "500",
    "1000",
    "1500",
    "2000",
    "2500",
    "3000",
    "3500",
    "4000",
    "4500",
    "5000",
    "5500",
    "6000",
    "6500",
    "7000",
    "7500",
    "8000",
    "8500",
    "9000",
    "9500",
    "10000",
    "15000"
  ];

  final feeStatusArrayList = ["UNPAID", "PAID"];
  final genderArrayList = ["MALE", "FEMALE"];

  String? selectedGroup = "",
      selectClass = "",
      academyStatus = "",
      feeStatus = "",
      selectedGender = "";
  String subject1 = "",
      subject2 = "",
      subject3 = "",
      subject4 = "",
      subject5 = "",
      subject6 = "",
      subject7 = "",
      subject8 = "",
      subject9 = "",
      selectedSubjectPrice = "",
      selectedSubjectPrice2 = "",
      selectedSubjectPrice3 = "",
      selectedSubjectPrice4 = "",
      selectedSubjectPrice5 = "",
      selectedSubjectPrice6 = "",
      selectedSubjectPrice7 = "",
      selectedSubjectPrice8 = "",
      selectedSubjectPrice9 = "";

  var myFormkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var fatherNameController = TextEditingController();
  var fatherCNICController = TextEditingController();
  var classGroupNameController = TextEditingController();
  var schoolNameController = TextEditingController();
  var dailyTestController = TextEditingController();
  var servicesChargesController = TextEditingController();
  var extraChargesController = TextEditingController();
  var discountController = TextEditingController();
  var studentLanguageController = TextEditingController();
  var studentAlreadyAttendingController = TextEditingController();

  var dobController = TextEditingController();
  var religionController = TextEditingController();
  var nationalityController = TextEditingController();
  var studentAddressController = TextEditingController();
  var contactNumberController = TextEditingController();
  var whatsappNumberController = TextEditingController();
  var medicalConditionController = TextEditingController();
  var residenceNumberController = TextEditingController();
  var studentRegistrationNumberController = TextEditingController();
  var studentImageURLController = TextEditingController();

  //subject prices
  var subject1PriceController = TextEditingController();
  var subject2PriceController = TextEditingController();
  var subject3PriceController = TextEditingController();
  var subject4PriceController = TextEditingController();
  var subject5PriceController = TextEditingController();
  var subject6PriceController = TextEditingController();
  var subject7PriceController = TextEditingController();
  var subject8PriceController = TextEditingController();

  var totalDues = 0;
  int dailyTest = 0, servicesCharges = 0;
  int kgAllSubjectPrice = 1000,
      fourAllSubjectPrice = 1500,
      eightAllSubjectPrice = 2000;

  var pictureStatus = "Upload Student Profile";

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  var imgUrl = "";

  var blackColors = Colors.black;
  var studentPicID = "";

  final collectRef = FirebaseFirestore.instance.collection("StudentFormsCount");
  var formsCounter = "";
  var formID = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder <ImageController>(
      init: ImageController(),
        builder: (controller){
          return FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Something went Wrong"),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Student Registration"),
                  ),
                  body: Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: AlignmentDirectional.center,
                              width: 100,
                              height: 100,
                              child: Image.asset("assets/images/aleezay.webp"),
                            ),
                            Form(
                                key: myFormkey,
                                child: Column(
                                  children: <Widget>[
                                    const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Student Details",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 21,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                    Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(1),
                                        2: FlexColumnWidth(4),
                                        3: FlexColumnWidth(3),
                                        4: FlexColumnWidth(1),
                                        5: FlexColumnWidth(1),
                                      },
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            width: 50,
                                          ),
                                          Container(
                                            width: 50,
                                          ),
                                          //student name
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller:
                                              studentRegistrationNumberController,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Enter Student Registration Number";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText:
                                                  "Student Registration Number",
                                                  hintText:
                                                  "Student Registration Number",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: selectedGender,
                                              items: genderArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGender = value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.blue.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Gender",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                          ),
                                          Container(
                                            width: 50,
                                          ),
                                        ]),
                                      ],
                                    ),

                                    Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(4),
                                        2: FlexColumnWidth(4),
                                        3: FlexColumnWidth(4),
                                        4: FlexColumnWidth(1)
                                      },
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            width: 50,
                                          ),
                                          //student name
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: nameController,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Enter Student Name";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Student Name",
                                                  hintText: "Student Full Name",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          //Father name
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: fatherNameController,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Enter Father Name";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Father Name",
                                                  hintText: "Student Father Name",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          //Father CNIC
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: fatherCNICController,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(
                                                    RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    value.length > 13 ||
                                                    value.length < 13) {
                                                  return "Enter Father CNIC";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Father CNIC",
                                                  hintText: "Father CNIC",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: 50,
                                          ),
                                          //student Date Of Birth
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: dobController,
                                              onTap: () {
                                                _showDatePicker();
                                              },
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Enter Student Date Of Birth";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Student DOB",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          //Student Religion
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: religionController,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Religion";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Religion",
                                                  hintText: "Religion",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          //Student nationality
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: nationalityController,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Nationality";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Nationality",
                                                  hintText: "Nationality",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: 50,
                                          ),
                                          //Medical Condition
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: medicalConditionController,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Enter Student Medical Condition";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Medical Condition",
                                                  hintText: "Medical Condition",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          //Class name
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: selectClass,
                                              items: classArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectClass = value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Student Class",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amberAccent,
                                                  )),
                                            ),
                                          ),
                                          //student group
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: selectedGroup,
                                              items: groupArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGroup = value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Student Group",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                          ),
                                        ]),
                                      ],
                                    ),
                                    //Student Address numbDetails
                                    Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(0.8),
                                        1: FlexColumnWidth(10),
                                        2: FlexColumnWidth(0.8),
                                      },
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Student Address
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: studentAddressController,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Enter Student Address";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Student Address",
                                                  hintText: "Student Address",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //school name
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: schoolNameController,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Student  School Name required";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "School Name",
                                                  hintText: "Student School Name",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Student Language
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: studentLanguageController,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Student language required";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText:
                                                  "Language commonly spoken at home",
                                                  hintText:
                                                  "Language commonly spoken at home",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Student Language
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller:
                                              studentAlreadyAttendingController,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "field required";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText:
                                                  "Name and classes of any brother(s)/sister(s) already attending the academy",
                                                  hintText:
                                                  "Name and classes of any brother(s)/sister(s) already attending the academy",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Student Language
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: studentImageURLController,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "field required";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText:
                                                  "Student Image URL for PDF",
                                                  hintText:
                                                  "Student Image URL for PDF",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                      ],
                                    ),

                                    //Picture Upload Table
                                    Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(0.8),
                                        1: FlexColumnWidth(4),
                                        2: FlexColumnWidth(2),
                                        3: FlexColumnWidth(3),
                                        4: FlexColumnWidth(0.8),
                                      },
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Total Dues
                                          Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                pictureStatus,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )),
                                          Container(
                                            width: 20,
                                          ),
                                          //Button
                                          SizedBox(
                                            height: 50,
                                            width: 200,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  uploadToStorage();
                                                },
                                                child: const Text("Upload Now")),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                      ],
                                    ),

                                    //Contact Table
                                    Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(0.6),
                                        1: FlexColumnWidth(4),
                                        2: FlexColumnWidth(4),
                                        3: FlexColumnWidth(0.6),
                                      },
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Parent Contact
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: contactNumberController,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(
                                                    RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    value.length > 11 ||
                                                    value.length < 11) {
                                                  return "Contact Number Required";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Contact Number",
                                                  hintText: "Contact Number",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.black,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          //Whatsapp number
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: whatsappNumberController,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(
                                                    RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    value.length > 11 ||
                                                    value.length < 11) {
                                                  return "Whatsapp number";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Whatsapp Number",
                                                  hintText: "Whatsapp Number",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  prefixIcon: Icon(
                                                    Icons.chat_bubble,
                                                    color: Colors.black,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                      ],
                                    ),
                                    //Contact Table
                                    Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(0.6),
                                        1: FlexColumnWidth(4),
                                        2: FlexColumnWidth(4),
                                        3: FlexColumnWidth(0.6),
                                      },
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Parent Contact
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: residenceNumberController,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(
                                                    RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    value.length > 11 ||
                                                    value.length < 11) {
                                                  return "Residence Number Required";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Residence Number",
                                                  hintText: "Residence Number",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.black,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          //Whatsapp number
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: DropdownButtonFormField(
                                                value: academyStatus,
                                                items: academyStatusArrayList
                                                    .map((e) => DropdownMenuItem(
                                                  child: Text(e),
                                                  value: e,
                                                ))
                                                    .toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    academyStatus = value as String;
                                                  });
                                                  // selectedGroup = value as String;
                                                },
                                                icon: const Icon(
                                                  Icons.arrow_drop_down_circle,
                                                  color: Colors.amber,
                                                ),
                                                dropdownColor: Colors.amber.shade50,
                                                decoration: const InputDecoration(
                                                    labelText: "Academy Status",
                                                    prefixIcon: Icon(
                                                      Icons.class_sharp,
                                                      color: Colors.amber,
                                                    )),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                      ],
                                    ),
                                    //Subject Details Text
                                    const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Student Subject Details",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 21,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),

                                    //Subject Table
                                    Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(0.6),
                                        1: FlexColumnWidth(4),
                                        2: FlexColumnWidth(4),
                                        3: FlexColumnWidth(0.6),
                                      },
                                      children: [
                                        //Subejct 1
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //subject 1
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: subject1,
                                              items: subjectArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  subject1 = value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Subject 1",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          //Subject Price
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: selectedSubjectPrice,
                                              items: subjectPriceArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedSubjectPrice =
                                                  value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Student Price",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                        // Subject 2
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //subject 2
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: subject2,
                                              items: subjectArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  subject2 = value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Subject 2",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          //Subject Price
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: selectedSubjectPrice2,
                                              items: subjectPriceArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedSubjectPrice2 =
                                                  value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Student Price",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                        // Subject 3
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Subject 3
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: subject3,
                                              items: subjectArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  subject3 = value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Subject 3",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          //Subject Price
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: selectedSubjectPrice3,
                                              items: subjectPriceArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedSubjectPrice3 =
                                                  value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Student Price",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                        // Subject 4
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Subject 4
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: subject4,
                                              items: subjectArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  subject4 = value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Subject 4",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          //Subject Price
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: selectedSubjectPrice4,
                                              items: subjectPriceArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedSubjectPrice4 =
                                                  value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Student Price",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                        // Subject 5
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Subject 5
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: subject5,
                                              items: subjectArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  subject5 = value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Subject 5",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          //Subject Price
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: selectedSubjectPrice5,
                                              items: subjectPriceArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedSubjectPrice5 =
                                                  value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Student Price",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                        // Subject 6
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Subject 6
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: subject6,
                                              items: subjectArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  subject6 = value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Subject 6",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          //Subject Price
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: selectedSubjectPrice6,
                                              items: subjectPriceArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedSubjectPrice6 =
                                                  value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Student Price",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                        // Subject 7
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Subject 7
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: subject7,
                                              items: subjectArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  subject7 = value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Subject 7",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          //Subject Price
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: selectedSubjectPrice7,
                                              items: subjectPriceArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedSubjectPrice7 =
                                                  value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Student Price",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),

                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                        // Subject 8
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Subject 8
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: subject8,
                                              items: subjectArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  subject8 = value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Subject 8",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          //Subject Price
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: selectedSubjectPrice8,
                                              items: subjectPriceArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedSubjectPrice8 =
                                                  value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Subject Price",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),

                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                        // Subject 9
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Subject 9
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: subject9,
                                              items: subjectArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  subject9 = value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Subject 9",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          //Subject Price
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: selectedSubjectPrice9,
                                              items: subjectPriceArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedSubjectPrice9 =
                                                  value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Subject Price",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),

                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                      ],
                                    ),

                                    const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Student Fee Details",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 21,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),

                                    const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Parent Default Password = 12345",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),

                                    //dues table
                                    Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(4),
                                        2: FlexColumnWidth(4),
                                        3: FlexColumnWidth(4),
                                        4: FlexColumnWidth(4),
                                        5: FlexColumnWidth(1)
                                      },
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            width: 50,
                                          ),
                                          //daily cahrges
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: dailyTestController,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(
                                                    RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Daily test required";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Daily Test",
                                                  hintText: "Daily Test",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          //services Charges
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: servicesChargesController,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(
                                                    RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Services charges required";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Services Fee",
                                                  hintText: "Enter Services Fee",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          //Extra Charges
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: extraChargesController,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(
                                                    RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              decoration: InputDecoration(
                                                  labelText: "Extra Charges",
                                                  hintText: "Enter Extra Charges",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          //Discount Charges
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: discountController,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(
                                                    RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Discount required";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Discount Charges",
                                                  hintText: "Discount",
                                                  hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                          ),
                                        ]),
                                      ],
                                    ),

                                    Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(0.8),
                                        1: FlexColumnWidth(4),
                                        2: FlexColumnWidth(2),
                                        3: FlexColumnWidth(3),
                                        4: FlexColumnWidth(0.8),
                                      },
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Total Dues
                                          Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "Total Dues = $totalDues",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )),
                                          Container(
                                            width: 20,
                                          ),
                                          //Button
                                          SizedBox(
                                            height: 50,
                                            width: 200,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  if (myFormkey.currentState!
                                                      .validate()) {
                                                    clickFunctionTotalDues();
                                                  }
                                                },
                                                child: const Text("Calculate Dues")),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),

                                    const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Student Fee Status",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 21,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),

                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(0.8),
                                        1: FlexColumnWidth(4),
                                        2: FlexColumnWidth(2),
                                        3: FlexColumnWidth(3),
                                        4: FlexColumnWidth(0.8),
                                      },
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            width: 20,
                                          ),
                                          //Total Dues
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(""),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                          //Fee Status
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: DropdownButtonFormField(
                                              value: feeStatus,
                                              items: feeStatusArrayList
                                                  .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  feeStatus = value as String;
                                                });
                                                // selectedGroup = value as String;
                                              },
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.amber,
                                              ),
                                              dropdownColor: Colors.amber.shade50,
                                              decoration: const InputDecoration(
                                                  labelText: "Fee Status",
                                                  prefixIcon: Icon(
                                                    Icons.class_sharp,
                                                    color: Colors.amber,
                                                  )),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                          ),
                                        ]),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 60,
                                    ),
                                    //Button
                                    SizedBox(
                                      height: 50,
                                      width: 300,
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            if (myFormkey.currentState!.validate()) {
                                              if (totalDues == 0 || imgUrl == "") {
                                                Fluttertoast.showToast(
                                                    msg: "Some field are missing",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 3,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else {
                                                saveData();
                                              }
                                            }
                                          },
                                          child: const Text("Save Data & Preview")),
                                    ),
                                  ],
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        });
    // TODO: implement build

  }

  void saveData() async {
    var today = DateTime.now();
    var dateFormat = DateFormat('dd-MM-yyyy');

    // var  onlyYear = DateFormat('yyyy');
    // var  onlyMonth = DateFormat('MM');
    String currentDate = dateFormat.format(today);

    String totalStudentDues = totalDues.toString();

    String currentTime = DateFormat("hh:mm:ss a").format(DateTime.now());

    await firestoredatabase
        .collection("StudentRegistration")
        .doc(formID.toString())
        .set({
      "studentName": nameController.text.toUpperCase(),
      "studentFatherName": fatherNameController.text.toUpperCase(),
      "studentFatherCNIC": fatherCNICController.text,
      "studentGroupName": selectedGroup.toString().toUpperCase(),
      "studentClassName": selectClass.toString().toUpperCase(),
      "studentSchoolName": schoolNameController.text.toUpperCase(),
      "studentAddress": studentAddressController.text.toUpperCase(),
      "studentDOB": dobController.text,
      "studentReligion": religionController.text.toUpperCase(),
      "studentNationality": nationalityController.text.toUpperCase(),
      "medicalCondition": medicalConditionController.text.toUpperCase(),
      "studentLanguage": studentLanguageController.text.toUpperCase(),
      "studentAlreadyAttending":
          studentAlreadyAttendingController.text.toUpperCase(),
      "contactNumber": contactNumberController.text,
      "whatsappNumber": whatsappNumberController.text,
      "residenceNumber": residenceNumberController.text,
      "subject1": subject1.toString().toUpperCase(),
      "subject2": subject2.toString().toUpperCase(),
      "subject3": subject3.toString().toUpperCase(),
      "subject4": subject4.toString().toUpperCase(),
      "subject5": subject5.toString().toUpperCase(),
      "subject6": subject6.toString().toUpperCase(),
      "subject7": subject7.toString().toUpperCase(),
      "subject8": subject8.toString().toUpperCase(),
      "subject9": subject9.toString().toUpperCase(),
      "studentImageProfile": imgUrl,
      "subject1Price": selectedSubjectPrice,
      "subject2Price": selectedSubjectPrice2,
      "subject3Price": selectedSubjectPrice3,
      "subject4Price": selectedSubjectPrice4,
      "subject5Price": selectedSubjectPrice5,
      "subject6Price": selectedSubjectPrice6,
      "subject7Price": selectedSubjectPrice7,
      "subject8Price": selectedSubjectPrice8,
      "subject9Price": selectedSubjectPrice9,
      "appPassword": "12345",
      "studentFormID": formID.toString(),
      "admissionDate": currentDate.toString(),
      "admissionTime": currentTime,
      "academyStatus": academyStatus.toString().toUpperCase(),
      "dailyTest": dailyTestController.text,
      "servicesCharges": servicesChargesController.text,
      "extraCharges": extraChargesController.text,
      "discountCharges": discountController.text,
      "totalDues": totalStudentDues,
      "admissionID": fatherCNICController.text,
      "feeStatus": feeStatus.toString().toUpperCase(),
      "registrationNumber": studentRegistrationNumberController.text.toString(),
      "gender": selectedGender.toString().toUpperCase(),
      "studentImageUrl": studentImageURLController.text.toString(),
    }).whenComplete(() {
      updateFormID();
      Fluttertoast.showToast(
          msg: "Student Register successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    });

    // await firestoredatabase.collection("StudentRegistration").doc(fatherCNICController.text)
    // .collection("Students").add({
    //   "studentName" : nameController.text.toUpperCase(),
    //   "studentFatherName" : fatherNameController.text.toUpperCase(),
    //   "studentFatherCNIC" : fatherCNICController.text,
    //   "studentGroupName" : selectedGroup.toString().toUpperCase(),
    //   "studentClassName" : selectClass.toString().toUpperCase(),
    //   "studentSchoolName" : schoolNameController.text.toUpperCase(),
    //   "studentAddress" : studentAddressController.text.toUpperCase(),
    //   "studentDOB" : dobController.text,
    //   "studentReligion" : religionController.text.toUpperCase(),
    //   "studentNationality" : nationalityController.text.toUpperCase(),
    //   "medicalCondition" : medicalConditionController.text.toUpperCase(),
    //   "studentLanguage" : studentLanguageController.text.toUpperCase(),
    //   "contactNumber" : contactNumberController.text,
    //   "whatsappNumber" : whatsappNumberController.text,
    //   "residenceNumber" : residenceNumberController.text,
    //   "subject1": subject1.toString().toUpperCase(),
    //   "subject2": subject2.toString().toUpperCase(),
    //   "subject3": subject3.toString().toUpperCase(),
    //   "subject4": subject4.toString().toUpperCase(),
    //   "subject5": subject5.toString().toUpperCase(),
    //   "subject6": subject6.toString().toUpperCase(),
    //   "subject7": subject7.toString().toUpperCase(),
    //   "subject8": subject8.toString().toUpperCase(),
    //   "subject9": subject9.toString().toUpperCase(),
    //   "studentImageProfile": imgUrl,
    //   "subject1Price": selectedSubjectPrice,
    //   "subject2Price": selectedSubjectPrice2,
    //   "subject3Price": selectedSubjectPrice3,
    //   "subject4Price": selectedSubjectPrice4,
    //   "subject5Price": selectedSubjectPrice5,
    //   "subject6Price": selectedSubjectPrice6,
    //   "subject7Price": selectedSubjectPrice7,
    //   "subject8Price": selectedSubjectPrice8,
    //   "subject9Price": selectedSubjectPrice9,
    //   "appPassword": "12345",
    //   "studentFormID": formID.toString(),
    //   "admissionDate": currentDate.toString(),
    //   "admissionTime": currentTime,
    //   "academyStatus": academyStatus.toString().toUpperCase(),
    //   "dailyTest": dailyTestController.text,
    //   "servicesCharges": servicesChargesController.text,
    //   "extraCharges": extraChargesController.text,
    //   "discountCharges": discountController.text,
    //   "totalDues": totalStudentDues,
    //   "admissionID": fatherCNICController.text,
    // }).then((DocumentReference reference) {
    //   String id = reference.id;
    //   firestoredatabase.collection("StudentRegistration").doc(fatherCNICController.text)
    //       .collection("Students").doc(id).update({
    //       "studentAdmissionID":id,
    //       })
    // });
  }

  void updateFormID() {
    collectRef
        .doc("FormsCounter")
        .update({"formNumber": formID.toString()})
        .whenComplete(() {
      _checkParentAccountExits(formID.toString());
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: "Something went wrong! try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void _checkParentAccountExits(String id) {
    FirebaseFirestore.instance
        .collection('ParentAccounts')
        .doc(fatherCNICController.text)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        moveToDetailsPage();
      } else {
        _appPasswordSaved();
      }
    });
  }

  void _updateStudentKey(String id) async {
    int num = 0;

    await firestoredatabase
        .collection("ParentAccounts")
        .doc(fatherCNICController.text)
        .collection("Students")
        .doc(id)
        .update({
      "student${num++}": id,
    }).whenComplete(() {
      Fluttertoast.showToast(
          msg: "Parent Account Updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: "Something went wrong! try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void _appPasswordSaved() async {
    await firestoredatabase
        .collection("ParentAccounts")
        .doc(fatherCNICController.text)
        .set({
      "username": fatherCNICController.text,
      "appPassword": "12345",
      "changePassword": false,
    }).whenComplete(
      () {
        moveToDetailsPage();
        Fluttertoast.showToast(
            msg: "Parent Account Created",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    ).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: "Something went wrong! try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void moveToDetailsPage() {
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => DisplayFormScreen(
    //         "${nameController.text.toString().toUpperCase()}",
    //         "${fatherNameController.text.toString().toUpperCase()}",
    //         "${fatherCNICController.text.toString()}",
    //         "${selectClass.toString().toUpperCase()}",
    //         "${selectedGroup.toString().toUpperCase()}",
    //         "${schoolNameController.text.toString().toUpperCase()}",
    //         "${studentAddressController.text.toString().toUpperCase()}",
    //         "${dobController.text.toString()}",
    //         "${religionController.text.toString().toUpperCase()}",
    //         "${nationalityController.text.toString().toUpperCase()}",
    //         "${medicalConditionController.text.toString().toUpperCase()}",
    //         "${contactNumberController.text.toString()}",
    //         "${whatsappNumberController.text.toString()}",
    //         "${residenceNumberController.text.toString()}",
    //
    //         //subject name and Prices
    //         "${subject1.toString().toUpperCase()}",
    //         "${selectedSubjectPrice.toString()}",
    //         "${subject2.toString().toUpperCase()}",
    //         "${selectedSubjectPrice2.toString()}",
    //         "${subject3.toString().toUpperCase()}",
    //         "${selectedSubjectPrice3.toString()}",
    //         "${subject4.toString().toUpperCase()}",
    //         "${selectedSubjectPrice4.toString()}",
    //         "${subject5.toString().toUpperCase()}",
    //         "${selectedSubjectPrice5.toString()}",
    //         "${subject6.toString().toUpperCase()}",
    //         "${selectedSubjectPrice6.toString()}",
    //         "${subject7.toString().toUpperCase()}",
    //         "${selectedSubjectPrice7.toString()}",
    //         "${subject8.toString().toUpperCase()}",
    //         "${selectedSubjectPrice8.toString()}",
    //         "${dailyTestController.text.toString()}",
    //         "${servicesChargesController.text.toString()}",
    //         "${extraChargesController.text.toString()}",
    //         "${totalDues.toString()}",
    //         "${discountController.text.toString()}",
    //         "${studentLanguageController.text.toString().toUpperCase()}",
    //         "${subject9.toString().toUpperCase()}",
    //         "${selectedSubjectPrice9.toString()}",
    //         "${formID.toString()}",
    //         "${academyStatus.toString().toUpperCase()}",
    //         "${studentAlreadyAttendingController.text.toString().toUpperCase()}",
    //         "${feeStatus.toString().toUpperCase()}",
    //         "${studentRegistrationNumberController.text.toString()}",
    //         "${imgUrl.toString()}",
    //         "${selectedGender.toString().toUpperCase()}",
    //         "${studentImageURLController.text.toString()}",
    //       ),
    //     ));
  }

  uploadToStorage() {
    FileUploadInputElement input = FileUploadInputElement()..accept = 'image/*';
    FirebaseStorage fs = FirebaseStorage.instance;
    input.click();
    input.onChange.listen((event) {
      final file = input.files?.first;
      final reader = FileReader();
      final dateTime = DateTime.now().millisecondsSinceEpoch.toString();
      final fileName = 'image_$dateTime.jpg';

      reader.readAsDataUrl(file!);
      reader.onLoadEnd.listen((event) async {
        var snapshot = await fs.ref().child(fileName).putBlob(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imgUrl = downloadUrl;
          pictureStatus = "Student Picture uploaded successfully";
          Fluttertoast.showToast(
              msg: "Picture uploaded",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        });
      });
    });
  }

  void _showDatePicker() async {
    DateTime? picDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2050));

    setState(() {
      dobController.text = DateFormat('dd-MM-yyyy').format(picDate!);
    });
  }

  void getUserValues() {
    collectRef.doc("FormsCounter").get().then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        formsCounter = snapshot.get("formNumber");
        formID = int.parse(formsCounter) + 1;
        print("Form ID $formID");
      }
    });
  }
}
