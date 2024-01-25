import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:legends_schools_admin/controller/image_controller.dart';
import 'package:legends_schools_admin/helper/button_widget.dart';
import 'package:legends_schools_admin/helper/image_path.dart';
import 'package:legends_schools_admin/helper/my_color.dart';
import 'package:legends_schools_admin/helper/my_toast.dart';
import 'package:legends_schools_admin/helper/text_helper.dart';
import 'package:legends_schools_admin/main/form_display.dart';

import '../helper/my_input_field.dart';

class StudentAdmissionFormScreen extends StatefulWidget {
  const StudentAdmissionFormScreen({Key? key}) : super(key: key);

  @override
  State<StudentAdmissionFormScreen> createState() => _StudentAdmissionFormScreenState();
}

class _StudentAdmissionFormScreenState extends State<StudentAdmissionFormScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserValues();
  }

  _StudentAdmissionFormScreenState()
  {
    selectedClass = classArrayList[0];
    selectedGender = genderArrayList[0];
  }

  String? selectedClass = "",selectedGender = "",selectedSection = "";
  final classArrayList = [
    'Play',
    'Nursery',
    'Prep',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six girls',
    'Six boys',
    'Seven girls',
    'Seven boys',
    'Eight girls',
    'Eight boys',
    'Nine girls',
    'Nine boys',
    'Ten girls',
    'Ten boys',
    '1st year girls',
    '1st year boys',
    '2nd year girls',
    '2nd year boys',
  ];

  final genderArrayList = ['MALE','FEMALE','OTHER'];

  bool isLoading = false;

  var myFormKey = GlobalKey<FormState>();
  var dobController = TextEditingController();
  var admissionDateController = TextEditingController();
  var nameController = TextEditingController();
  var bFormController = TextEditingController();
  var fatherNameController = TextEditingController();
  var cnicController = TextEditingController();
  var occupationController = TextEditingController();
  var religionController = TextEditingController();
  var castleController = TextEditingController();
  var addressController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var residenceController = TextEditingController();
  var admissionYearController = TextEditingController();
  var referenceController = TextEditingController();
  var languageSpokenController = TextEditingController();
  var whatsappController = TextEditingController();
  var schoolNameController = TextEditingController();
  var feeController = TextEditingController();
  var registrationController = TextEditingController();
  var schoolAddressController = TextEditingController();
  var pdfUrlController = TextEditingController();


  bool isPickerDOB = false;
  bool agriCheck = false;
  bool nonAgriCheck = false;

  FirebaseFirestore firestoredatabase = FirebaseFirestore.instance;



  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  var imgUrl = "";

  final collectRef = FirebaseFirestore.instance.collection("StudentFormsCount");
  var formsCounter = "",year,month,days;
  var formID = 0;

  var topColor = Colors.black;
  var pictureStatus = "Upload Student Profile",accountStatus = "Registration Form";

  @override
  Widget build(BuildContext context) {

    return GetBuilder <ImageController>(
      init: ImageController(),
        builder: (controller){
          return Scaffold(
            appBar: AppBar(
              title: Text("Student Admission Form",style: TextStyle(color: MyColor().whiteColor),),
              backgroundColor: MyColor().mainColor,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: MyColor().mainColor
                              ),

                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Container(
                                    height: 100,
                                    child: controller.pickedImage!=null ?
                                    Image.memory(controller.pickedImage!) :
                                    Text(pictureStatus)
                                ),

                                SizedBox(height: 20,),

                                ButtonWidget(
                                    text: "Upload",
                                    width: 100,
                                    height: 50,
                                    onClicked: (){
                                      // uploadToStorage();
                                      controller.pickImageMethod();
                                    }
                                ),


                                SizedBox(height: 10,
                                ),
                              ],
                            ),
                          )
                      ),

                      Expanded(
                          flex: 6,
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(ImagePath().logoImagePath,width: 150,height: 150,),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20,bottom: 10),
                                child: Text(accountStatus,style: TextStyle(color: topColor,fontWeight: FontWeight.bold,fontSize: 16)),
                              ),
                            ],
                          )
                      ),

                      Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text("Class Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black)
                                ),
                              ),
                              Container(
                                width: 300,
                                padding: EdgeInsets.all(10.0),
                                child: DropdownButtonFormField(
                                  value: selectedClass,
                                  items: classArrayList
                                      .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedClass = value as String;
                                    });
                                    // selectedGroup = value as String;
                                  },
                                  icon:  Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: MyColor().mainColor,
                                  ),
                                  dropdownColor: Colors.amber.shade50,
                                  decoration:  InputDecoration(
                                      labelText: "Student Class",
                                      prefixIcon: Icon(
                                        Icons.class_sharp,
                                        color: MyColor().mainColor,
                                      )),
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 10,top: 20),
                                child: Text("Admission Date",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black)
                                ),
                              ),
                              Container(
                                width: 300,
                                padding: EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: admissionDateController,
                                  onTap: () {
                                    isPickerDOB = false;
                                    _showDatePicker();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter Student Admission Date";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Admission Date",
                                      hintStyle: const TextStyle(
                                        fontSize: 12,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              5.0))),
                                ),
                              ),
                            ],
                          )
                      )

                    ],
                  ),



                  // field start
                  SizedBox(height: 50,),
                  Form(
                    key: myFormKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: 500,
                                height: 50,
                                margin: EdgeInsets.only(left: 50,right: 10),
                                child: MyCustomInputField(
                                    "Name".toUpperCase(),"Name".toUpperCase(),nameController
                                ),
                              ),),
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: 500,
                                height: 50,
                                margin: EdgeInsets.only(left: 20,right: 10),
                                child: MyCustomInputField(
                                    "Student B.Form".toUpperCase(),"Student B.Form".toUpperCase(),bFormController
                                ),
                              ),),
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: 500,
                                height: 50,
                                margin: EdgeInsets.only(left: 20,right: 50),
                                child: MyCustomInputField(
                                    "Registration Number".toUpperCase(),"Registration Number".toUpperCase(),registrationController
                                ),
                              ),),
                          ],
                        ),

                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: 500,
                                height: 50,
                                margin: EdgeInsets.only(left: 50,right: 10),
                                child: MyCustomInputField(
                                    "FATHER Name".toUpperCase(),"FATHER name".toUpperCase(),fatherNameController
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: 500,
                                height: 50,
                                margin: EdgeInsets.only(left: 20,right: 10),
                                child: TextFormField(
                                  controller: dobController,
                                  onTap: () {
                                    isPickerDOB = true;
                                    _showDatePicker();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter Student DOB";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Date of birth".toUpperCase(),
                                      hintStyle: const TextStyle(
                                        fontSize: 12,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              5.0))),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: 500,
                                height: 50,
                                margin: EdgeInsets.only(left: 20,right: 50),
                                child: MyCustomInputField(
                                    "Father cnic".toUpperCase(),"Father cnic".toUpperCase(),cnicController
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex:3,
                              child:   Container(
                                width: 500,
                                height: 50,
                                margin: EdgeInsets.only(left: 50,right: 10),
                                child: MyCustomInputField(
                                    "father occupation".toUpperCase(),"father occupation".toUpperCase(),occupationController
                                ),
                              ),),

                            Expanded(
                              flex: 3,
                              child:  Container(
                                width: 500,
                                height: 50,
                                margin: EdgeInsets.only(left: 20,right: 10),
                                child: MyCustomInputField(
                                    "religion".toUpperCase(),"religion".toUpperCase(),religionController
                                ),
                              ),),
                            Expanded(
                              flex: 3,
                              child:  Container(
                                  width: 500,
                                  height: 50,
                                  margin: EdgeInsets.only(left: 20,right: 50),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 240,
                                        child: CheckboxListTile(
                                          title: Text("Agriculturist"),
                                          value: agriCheck,
                                          onChanged: (newValue) {
                                            setState(() {
                                              agriCheck = newValue!;
                                              nonAgriCheck = false;
                                            });
                                          },
                                          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                        ),
                                      ),
                                      Container(
                                        width: 240,
                                        child: CheckboxListTile(
                                          title: Text("Non Agriculturist"),
                                          value: nonAgriCheck,
                                          onChanged: (newValue) {
                                            setState(() {
                                              nonAgriCheck = newValue!;
                                              agriCheck = false;
                                            });
                                          },
                                          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                        ),
                                      ),
                                    ],
                                  )
                              ),)
                          ],
                        ),

                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Expanded(
                              flex:3,
                              child: Container(
                                width: 800,
                                height: 50,
                                margin: EdgeInsets.only(left: 50,right: 10),
                                child: MyCustomInputField(
                                    "School Name".toUpperCase(),"School Name".toUpperCase(),schoolNameController
                                ),
                              ),),



                            Expanded(
                              flex: 3,
                              child: Container(
                                width: 350,
                                height: 50,
                                margin: EdgeInsets.only(left: 20,right: 50),
                                child: MyCustomInputField(
                                    "School address".toUpperCase(),"School address".toUpperCase(),schoolAddressController
                                ),
                              ),)

                          ],
                        ),

                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Expanded(
                              flex:3,
                              child: Container(
                                width: 800,
                                height: 50,
                                margin: EdgeInsets.only(left: 50,right: 10),
                                child: MyCustomInputField(
                                    "Whatsapp Number".toUpperCase(),"Whatsapp Number".toUpperCase(),whatsappController
                                ),
                              ),),


                            Expanded(
                              flex: 3,
                              child: Container(
                                width: 350,
                                height: 50,
                                margin: EdgeInsets.only(left: 20,right: 10),
                                child: MyCustomInputField(
                                    "Mobile Number".toUpperCase(),"Mobile Number".toUpperCase(),mobileNumberController
                                ),
                              ),),

                            Expanded(
                              flex: 3,
                              child: Container(
                                width: 350,
                                height: 50,
                                margin: EdgeInsets.only(left: 20,right: 50),
                                child: MyCustomInputField(
                                    "Residence Number".toUpperCase(),"Residence Number".toUpperCase(),residenceController
                                ),
                              ),)

                          ],
                        ),

                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Expanded(
                              flex:6,
                              child: Container(
                                width: 800,
                                height: 50,
                                margin: EdgeInsets.only(left: 50,right: 10),
                                child: MyCustomInputField(
                                    "Permanent Address".toUpperCase(),"Permanent Address".toUpperCase(),addressController
                                ),
                              ),),


                            Expanded(
                              flex: 2,
                              child: Container(
                                width: 350,
                                height: 50,
                                margin: EdgeInsets.only(left: 20,right: 10),
                                child: MyCustomInputField(
                                    "Language Spoken".toUpperCase(),"Language Spoken".toUpperCase(),languageSpokenController
                                ),
                              ),),

                            Expanded(
                              flex: 4,
                              child: Container(
                                width: 350,
                                height: 50,
                                margin: EdgeInsets.only(left: 20,right: 50),
                                child: MyCustomInputField(
                                    "Any Reference Student already study in LGSC".toUpperCase(),"Any Reference Student already study in LGSC".toUpperCase(),referenceController
                                ),
                              ),)

                          ],
                        ),


                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Expanded(
                              flex: 3,
                              child: Container(
                                width: 350,
                                height: 50,
                                margin: EdgeInsets.only(left: 50,right: 10),
                                child: MyCustomInputField(
                                    "Admission Year".toUpperCase(),"Admission Year".toUpperCase(),admissionYearController
                                ),
                              ),),

                            Expanded(
                              flex: 3,
                              child: Container(
                                width: 350,
                                height: 50,
                                margin: EdgeInsets.only(left: 50,right: 10),
                                child: MyCustomInputField(
                                    "PDF Image Url".toUpperCase(),"PDF Image Url".toUpperCase(),pdfUrlController
                                ),
                              ),),


                            Expanded(
                              flex: 3,
                              child:  Container(
                                width: 300,
                                margin: EdgeInsets.only(left: 10,right: 50),
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
                                  icon:  Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: MyColor().mainColor,
                                  ),
                                  dropdownColor: Colors.amber.shade50,
                                  decoration:  InputDecoration(
                                      labelText: "Student Gender",
                                      prefixIcon: Icon(
                                        Icons.class_sharp,
                                        color: MyColor().mainColor,
                                      )),
                                ),
                              ),
                            ),



                          ],
                        ),

                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Container(
                              width: 350,
                              height: 50,
                              margin: EdgeInsets.only(left: 50,right: 10),
                              child: MyCustomInputField(
                                  "Student Fee".toUpperCase(),"Student Fee".toUpperCase(),feeController
                              ),
                            ),



                          ],
                        ),


                        SizedBox(height: 50,),
                        ButtonWidget(text: "Save Record",
                            onClicked: () async{


                              if(dobController.text.isEmpty || nameController.text.isEmpty || fatherNameController.text.isEmpty
                                  || bFormController.text.isEmpty || cnicController.text.isEmpty || occupationController.text.isEmpty
                                  || religionController.text.isEmpty  || admissionYearController.text.isEmpty
                                  || mobileNumberController.text.isEmpty || residenceController.text.isEmpty || addressController.text.isEmpty
                                  || admissionDateController.text.isEmpty)
                              {
                                setState(() {
                                  accountStatus = "Please Filed Missing Fields";
                                  topColor = Colors.red;
                                });
                                MyToast().errorToast("Please Filed Missing Fields");
                              }else{
                                EasyLoading.show(status: "please wait");
                                String imageURL = await  controller.firebaseStorageImage(image: controller.pickedImage!);
                                saveData(imageURL);
                              }




                            },
                            width: 250, height: 50)

                      ],
                    ),
                  )

                ],
              ),
            ),
          );
        });

  }

  void _showDatePicker() async {
    DateTime? picDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2050));

    setState(() {
      if(isPickerDOB)
        {
          dobController.text = DateFormat('dd-MM-yyyy').format(picDate!);
        }else{
        admissionDateController.text = DateFormat('dd-MM-yyyy').format(picDate!);
      }

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
          MyToast().errorToast("Picture uploaded");
          closeWaitingDialog(context);
        });
      });
    });
  }

  void saveData(String imageUrl) async {



    setState(() {
      accountStatus = "Please wait";
      topColor = Colors.green;
    });

    var today = DateTime.now();
    var dateFormat = DateFormat('dd-MM-yyyy');

    // var  onlyYear = DateFormat('yyyy');
    // var  onlyMonth = DateFormat('MM');
    String currentDate = dateFormat.format(today);

    var yearFormatter = new DateFormat('yyyy');
    var monthFormatter = new DateFormat('MM');
    var daysFormatter = new DateFormat('dd');

    year = yearFormatter.format(today);
    month = monthFormatter.format(today);
    days = daysFormatter.format(today);

    String currentTime = DateFormat("hh:mm:ss a").format(DateTime.now());

    String agri = "";
    if(agriCheck)
    {
      agri = "Agriculturist";
    }

    if(nonAgriCheck)
    {
      agri = "Non Agriculturist";
    }

    await firestoredatabase
        .collection("admissions")
        .doc(formID.toString())
        .set({
      "studentName": nameController.text.toUpperCase(),
      "bForm": bFormController.text.toUpperCase(),
      "registrationNumber": registrationController.text.toUpperCase(),
      "fatherName": fatherNameController.text.toUpperCase(),
      "dateOfBirth": dobController.text,
      // "studentGroupName": selectedGroup.toString().toUpperCase(),
      "fatherCNIC": cnicController.text.toString().toUpperCase(),
      "occupation": occupationController.text.toString().toUpperCase(),
      "religion": religionController.text.toString().toUpperCase(),
      "schoolName": schoolNameController.text.toString().toUpperCase(),
      "schoolAddress": schoolAddressController.text.toString().toUpperCase(),
      "studentClassName": selectedClass.toString().toUpperCase(),
      "studentAddress": addressController.text.toUpperCase(),
      "contactNumber": mobileNumberController.text.toString(),
      "residenceNumber": residenceController.text.toString(),
      "appPassword": "12345",
      "studentFee": feeController.text.toString(),
      "studentImage": imageUrl.toString(),
      "pdfImageUrl": pdfUrlController.text.toString(),
      "admissionDate": currentDate.toString(),
      "admissionTime": currentTime,
      "studentStatus": "active",
      "admissionID": cnicController.text,
      "formSaveYear": year,
      "formSaveMonth": month,
      "admissionYear": admissionYearController.text.toString(),
      "agri": agri.toString().toUpperCase(),
      // "studentImageUrl": studentImageURLController.text.toString(),
    }).whenComplete(() {
      // updateFormID();
      EasyLoading.dismiss();
     MyToast().errorToast("Student Register successfully");
    });
  }

  void updateFormID() {
    collectRef
        .doc("FormsCounter")
        .update({"formNumber": formID.toString()})
        .whenComplete(() {
      _checkParentAccountExits(formID.toString());
    }).onError((error, stackTrace) {
      MyToast().errorToast("Something went wrong! try again");

    });
  }

  void _checkParentAccountExits(String id) {
    FirebaseFirestore.instance
        .collection('ParentAccounts')
        .doc(cnicController.text)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        moveToDetailsPage();
      } else {
        _appPasswordSaved();
      }
    });
  }

  void _appPasswordSaved() async {
    await firestoredatabase
        .collection("ParentAccounts")
        .doc(cnicController.text)
        .set({
      "username": cnicController.text,
      "appPassword": "12345",
      "changePassword": false,
    }).whenComplete(
          () {
        moveToDetailsPage();
        MyToast().errorToast("Parent Account Created");
      },
    ).onError((error, stackTrace) {
     MyToast().errorToast("Something went wrong! try again");
    });
  }


  void moveToDetailsPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FormDisplayScreen(
            "${nameController.text.toString().toUpperCase()}",
            "${fatherNameController.text.toString().toUpperCase()}",
            "${cnicController.text.toString()}",
            "${selectedClass.toString().toUpperCase()}",
            "${addressController.text.toString().toUpperCase()}",
            "${dobController.text.toString()}",
            "${religionController.text.toString().toUpperCase()}",
            "${mobileNumberController.text.toString()}",
            "${residenceController.text.toString()}",
            "${imgUrl.toString()}",
            "${formID.toString()}",


          ),
        ));
  }


  void showWaitingDialog() {
    setState(() {
      isLoading = true;
    });

    showDialog(
      context: context,
      barrierDismissible:
      false, // Dialog cannot be dismissed by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          content: InkWell(
            onTap: () {
              setState(() {
                isLoading = false;
                closeWaitingDialog(context);
              });
            },
            child: Row(
              children: [
                CircularProgressIndicator(), // Replace this with your custom loading indicator if desired
                SizedBox(
                    width:
                    16.0), // Add some spacing between the indicator and text
                Text("Please wait..."),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      // After the dialog is closed, set isLoading to false
      setState(() {
        isLoading = false;
      });
    });
  }

  void closeWaitingDialog(BuildContext context) {
    Navigator.pop(context);
  }

}


