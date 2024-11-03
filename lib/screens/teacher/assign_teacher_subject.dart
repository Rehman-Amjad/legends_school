import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssignTeacherSubjectScreen extends StatefulWidget {
  const AssignTeacherSubjectScreen({super.key});

  @override
  State<AssignTeacherSubjectScreen> createState() =>
      _AssignTeacherSubjectScreenState();
}

class _AssignTeacherSubjectScreenState
    extends State<AssignTeacherSubjectScreen> {
  _AssignTeacherSubjectScreenState() {
    selectedClass1 = classArrayList[0];
    selectedClass2 = classArrayList[0];
    selectedClass3 = classArrayList[0];
    selectedClass4 = classArrayList[0];
    selectedClass5 = classArrayList[0];
    selectedClass6 = classArrayList[0];
    selectedClass7 = classArrayList[0];
    selectedClass8 = classArrayList[0];
    selectedClass9 = classArrayList[0];
  }

  var taskText = "Choose subject to assign a teacher";
  FirebaseFirestore firestoredatabase = FirebaseFirestore.instance;
  var blackColor = Colors.black;
  final collectRef =
      FirebaseFirestore.instance.collection("teacherRegistrations");
  var teacherCNICController = TextEditingController();
  String? selectedClass1 = "",
      selectedClass2 = "",
      selectedClass3 = "",
      selectedClass4 = "",
      selectedClass5 = "",
      selectedClass6 = "",
      selectedClass7 = "",
      selectedClass8 = "",
      selectedClass9 = "";
  bool isChecked = false;
  final classArrayList = [
    'select class',
    'P.G',
    "K.G-I",
    "K.G-II",
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
    "Home Economics",
    "Punjabi"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assign Teacher Subject"),
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: AlignmentDirectional.center,
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(top: 10),
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(21)),
              ),
              child: Image.asset("assets/images/aleezay.webp"),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                taskText,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: blackColor),
              ),
            ),

            //Text Field for student attendance
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 500,
                  height: 50,
                  margin: EdgeInsets.only(top: 50),
                  child: TextField(
                    controller: teacherCNICController,
                    decoration: InputDecoration(
                        labelText: "Teacher CNIC",
                        hintText: "Teacher CNIC",
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Container(
                  width: 200,
                  height: 50,
                  margin: EdgeInsets.only(top: 50, left: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        saveTeacherSubject();
                      },
                      child: Text(
                        "Assign Class",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),

            // subject 1 row
            Row(
              children: [
                Expanded(flex: 1, child: Text("")),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: DropdownButtonFormField(
                      value: selectedClass1,
                      items: classArrayList
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClass1 = value as String;
                        });
                        // selectedGroup = value as String;
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.amber,
                      ),
                      dropdownColor: Colors.blue.shade50,
                      decoration: const InputDecoration(
                          labelText: "Select Class",
                          prefixIcon: Icon(
                            Icons.class_sharp,
                            color: Colors.amber,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: DropdownButtonFormField(
                      value: selectedClass2,
                      items: classArrayList
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClass2 = value as String;
                        });
                        // selectedGroup = value as String;
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.amber,
                      ),
                      dropdownColor: Colors.blue.shade50,
                      decoration: const InputDecoration(
                          labelText: "Select Class",
                          prefixIcon: Icon(
                            Icons.class_sharp,
                            color: Colors.amber,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: DropdownButtonFormField(
                      value: selectedClass3,
                      items: classArrayList
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClass3 = value as String;
                        });
                        // selectedGroup = value as String;
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.amber,
                      ),
                      dropdownColor: Colors.blue.shade50,
                      decoration: const InputDecoration(
                          labelText: "Select Class",
                          prefixIcon: Icon(
                            Icons.class_sharp,
                            color: Colors.amber,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: DropdownButtonFormField(
                      value: selectedClass4,
                      items: classArrayList
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClass4 = value as String;
                        });
                        // selectedGroup = value as String;
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.amber,
                      ),
                      dropdownColor: Colors.blue.shade50,
                      decoration: const InputDecoration(
                          labelText: "Select Class",
                          prefixIcon: Icon(
                            Icons.class_sharp,
                            color: Colors.amber,
                          )),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: Text(""))
              ],
            ),

            SizedBox(
              height: 10,
            ),

            // subject 2 row
            Row(
              children: [
                Expanded(flex: 1, child: Text("")),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: DropdownButtonFormField(
                      value: selectedClass5,
                      items: classArrayList
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClass5 = value as String;
                        });
                        // selectedGroup = value as String;
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.amber,
                      ),
                      dropdownColor: Colors.blue.shade50,
                      decoration: const InputDecoration(
                          labelText: "Select Class",
                          prefixIcon: Icon(
                            Icons.class_sharp,
                            color: Colors.amber,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: DropdownButtonFormField(
                      value: selectedClass6,
                      items: classArrayList
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClass6 = value as String;
                        });
                        // selectedGroup = value as String;
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.amber,
                      ),
                      dropdownColor: Colors.blue.shade50,
                      decoration: const InputDecoration(
                          labelText: "Select Class",
                          prefixIcon: Icon(
                            Icons.class_sharp,
                            color: Colors.amber,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: DropdownButtonFormField(
                      value: selectedClass7,
                      items: classArrayList
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClass7 = value as String;
                        });
                        // selectedGroup = value as String;
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.amber,
                      ),
                      dropdownColor: Colors.blue.shade50,
                      decoration: const InputDecoration(
                          labelText: "Select Class",
                          prefixIcon: Icon(
                            Icons.class_sharp,
                            color: Colors.amber,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: DropdownButtonFormField(
                      value: selectedClass8,
                      items: classArrayList
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClass8 = value as String;
                        });
                        // selectedGroup = value as String;
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.amber,
                      ),
                      dropdownColor: Colors.blue.shade50,
                      decoration: const InputDecoration(
                          labelText: "Select Class",
                          prefixIcon: Icon(
                            Icons.class_sharp,
                            color: Colors.amber,
                          )),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: Text(""))
              ],
            ),

            // subject 3 row
            Row(
              children: [
                Expanded(flex: 4, child: Text("")),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: DropdownButtonFormField(
                      value: selectedClass9,
                      items: classArrayList
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClass9 = value as String;
                        });
                        // selectedGroup = value as String;
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.amber,
                      ),
                      dropdownColor: Colors.blue.shade50,
                      decoration: const InputDecoration(
                          labelText: "Select Class",
                          prefixIcon: Icon(
                            Icons.class_sharp,
                            color: Colors.amber,
                          )),
                    ),
                  ),
                ),
                Expanded(flex: 4, child: Text(""))
              ],
            )
          ],
        ),
      ),
    );
  }

  void saveTeacherSubject() async {
    collectRef
        .doc(teacherCNICController.text.toString())
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        setState(() {
          taskText = "CNIC Exits please wait subject saving.....";
        });

        saveSubject();
      } else {
        setState(() {
          taskText = "sorry! we are not found the Teacher CNIC in database.";
        });
      }
    });
  }

  void saveSubject() async {
    await firestoredatabase
        .collection("teacherSubjects")
        .doc(teacherCNICController.text.toString())
        .set({
      'registrationID': teacherCNICController.text.toString(),
      'class1': selectedClass1.toString().toUpperCase(),
      'class2': selectedClass2.toString().toUpperCase(),
      'class3': selectedClass3.toString().toUpperCase(),
      'class4': selectedClass4.toString().toUpperCase(),
      'class5': selectedClass5.toString().toUpperCase(),
      'class6': selectedClass6.toString().toUpperCase(),
      'class7': selectedClass7.toString().toUpperCase(),
      'class8': selectedClass8.toString().toUpperCase(),
      'class9': selectedClass9.toString().toUpperCase(),
    }).whenComplete(() {
      setState(() {
        taskText = "Taecher class Save Completed";
      });
    }).onError((error, stackTrace) {
       setState(() {
        taskText = "Something went wrong...class cannot saved.";
      });
    });
  }
}
