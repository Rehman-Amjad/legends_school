import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/main/home_screen.dart';
import 'package:legends_schools_admin/start/dashboard_screen.dart';

class FormDisplayScreen extends StatelessWidget {

  var studentName,fatherName,bForm,fatherCnic,dob,fatherOccupation,religion,castle,agri,admissionYear,mobileNumber,residenceNumber
  ,address,className,imageUrl,formID;

  FormDisplayScreen(
      this.studentName,
      this.fatherName,
      this.fatherCnic,
      this.className,
      this.address,
      this.dob,
      this.religion,
      this.mobileNumber,
      this.residenceNumber,
      this.imageUrl,
      this.formID,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Student Registration Details"
                  ,style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.w600
                  ),),
              ),

              Table(
                children: [
                  //back Button
                  TableRow(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(10.0),
                          child: Image.asset("assets/images/aleezay.webp"),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Student Personal Details",style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen(),));
                            },
                            child: Text("Back to Home",style: TextStyle(
                              color: Colors.red,
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                            ),),
                          ),

                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(""),
                        ),
                      ]
                  ),
                  //Student Registration Number
                  TableRow(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Student Registration Number",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(residenceNumber),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child:  ElevatedButton(
                            onPressed: (){
                              // generatePDF(context);
                            },
                            child: Text("Download invoice"),
                          ),
                        ),
                        SizedBox(
                          child: Text(""),
                        ),
                      ]
                  ),

                  //Student FORM ID
                  TableRow(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Student Form ID",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(formID),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child:  Text("Academy Status",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("active"),
                        ),
                      ]
                  ),
                  //Student Name
                  TableRow(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Student Name:",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(studentName),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Student DOB",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(dob),
                        ),
                      ]
                  ),
                  //Student Father Name
                  TableRow(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Father Name:",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(fatherName),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Student Religion",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(religion),
                        ),
                      ]
                  ),
                  //Student Father CNIC
                  TableRow(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Father CNIC:",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(fatherCnic),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Student Nationality",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("studentNationality"),
                        ),
                      ]
                  ),
                  //Student Class
                  TableRow(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Student CLass:",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(className),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Address",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(address),
                        ),
                      ]
                  ),
                  //Student Class Group
                  TableRow(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Class Group:",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("studentClassGroup"),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Student Language",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("studentLanguage"),
                        ),
                      ]
                  ),
                  //Student School Name
                  TableRow(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("School:",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("schoolName"),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("Medical Condition",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text("medicalCondition"),
                        ),
                      ]
                  ),




                ],
              ),
              const SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Subject Details"
                  ,style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),),
              ),


              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Academy Fee Details"
                  ,style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),),
              ),

              const SizedBox(height: 40,),
            ],
          ),
        ],
      ),
    );
  }
}
