import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_schools_admin/config/component/app_text_field.dart';
import 'package:legends_schools_admin/config/component/app_text_widget.dart';
import 'package:legends_schools_admin/model/teacher_model.dart';
import 'package:legends_schools_admin/provider/registration/teacher_registration_provider.dart';
import 'package:legends_schools_admin/screens/admission/pdf/registration_pdf.dart';
import 'package:provider/provider.dart';
import '../../config/component/button_widget.dart';
import '../../config/component/dropdown_head_box.dart';
import '../../config/component/text_field_head_box.dart';
import '../../model/registration_form_model.dart';
import '../../provider/constant/action_provider.dart';
import '../../provider/constant/drop_down_provider.dart';
import '../../provider/constant/picker_provider.dart';
import '../../provider/registration/form_id_provider.dart';
import '../../provider/registration/registration_provider.dart';

class TeacherRegisterScreen extends StatelessWidget {

  final _key = GlobalKey<FormState>();

  TeacherRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dropDownProvider = Provider.of<DropdownProvider>(context,listen: false);
    final regP = Provider.of<TeacherRegistrationProvider>(context,listen: false);
    final imageProvider = Provider.of<PickerProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: AppTextWidget(text: "Teacher Registration",
            fontSize: 18.0,color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0,),
                AppTextWidget(text: "Teacher Registration Form", color: Colors.black,
                  fontSize: 18.0, fontWeight: FontWeight.bold,),
                SizedBox(height: 20.0,),
                Container(
                  width: Get.width,
                  padding: EdgeInsets.all(40.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Consumer<FormIdProvider>(
                          //   builder: (context,provider,child){
                          //     return AppTextWidget(text: "Form Number: ${provider.formID}",
                          //       color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold,);
                          //   },
                          // ),

                          SizedBox(
                            width: 200.0,
                            height: 300.0,
                            child: Consumer<PickerProvider>(
                                builder: (context, provider, child){
                                  return Column(
                                    children: [
                                      Container(
                                          width: 200.0,
                                          height: 200.0,
                                          color: Colors.grey,
                                          child: provider.pickedImage != null ? Image.memory(provider.pickedImage!) :
                                          null
                                      ),
                                      SizedBox(height: 20.0,),
                                      ButtonWidget(text: "Upload", onClicked: () async{
                                        provider.pickImage();
                                      }, width: 100.0, height: 50.0,)
                                    ],
                                  );
                                }
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: TextFieldHeadBox(labelText: "Registration No*",hintText: "Registration No",controller: regP.registrationNumberController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Name*",hintText: "Student Name",controller: regP.nameController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Father Name*",hintText: "Father Name",controller: regP.fatherNameController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "CNIC*",hintText: "Father CNIC",controller: regP.cNICController,),),
                        ],
                      ),

                      SizedBox(height: 20.0,),
                      Consumer<DropdownProvider>(
                        builder: (context, provider, child){
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Expanded(
                                  child: DropDownHeadBox(
                                    items: provider.genderList, selectedItem: provider.selectedGender,
                                    onChanged: (value){
                                      provider.changeGender(value.toString());
                                    }, labelText: 'Gender*',)
                              ),
                              Expanded(
                                  child: DropDownHeadBox(
                                    items: provider.classList, selectedItem: provider.selectedClass,
                                    onChanged: (classValue){
                                      provider.changeClass(classValue.toString());
                                    }, labelText: 'Teacher Class*',)
                              ),
                              Expanded(
                                  child: DropDownHeadBox(
                                    items: provider.groupList, selectedItem: provider.selectedGroup,
                                    onChanged: (value){
                                      provider.changeGroup(value.toString());
                                    }, labelText: 'Teacher Subject*',)
                              ),
                              Expanded(
                                  child: DropDownHeadBox(
                                    items: provider.statusList, selectedItem: provider.selectedStatus,
                                    onChanged: (value){
                                      provider.changeAcademyStatus(value.toString());
                                    }, labelText: 'Status*',)
                              ),
                            ],
                          );
                        },
                      ),

                      SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: TextFieldHeadBox(labelText: "Teacher Address*",hintText: "Teacher Address",controller: regP.addressController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Contact Number*",hintText: "Contact Number",controller: regP.contactController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Domicile*",
                            hintText: "Domicile", controller: regP.domicileController,),),
                        ],
                      ),

                      SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: TextFieldHeadBox(labelText: "Image Link For PDF*",hintText: "Image Link For PDF",controller: regP.pdfImageUrlController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Job Title*",hintText: "Job Title",controller: regP.jobTitleController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Qualification*",hintText: "Qualification",controller: regP.qualificationController,),),
                          const Expanded(child: SizedBox()),
                          //  Expanded(child: SizedBox()),
                        ],
                      ),

                      const SizedBox(height: 30.0,),
                      Divider(),
                      SizedBox(height: 20.0,),


                      Consumer<RegistrationProvider>(
                        builder: (context, provider, child){
                          return  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 10.0,),
                                  ButtonWidget(
                                      index: 2,
                                      text: "Save & Preview", onClicked: () async{
                                    if(_key.currentState!.validate() && imageProvider.pickedImage !=null){
                                      _key.currentState!.save();
                                      ActionProvider.startLoading(index: 2);
                                      final String imageUrl;
                                      if(imageProvider.pickedImage !=null){
                                        imageUrl = await imageProvider.firebaseStorageImage(image: imageProvider.pickedImage!);
                                      }else{
                                        imageUrl = '';
                                      }

                                      TeacherModel _model = TeacherModel(
                                          address: regP.addressController.text.toString(),
                                          appPassword: "12345",
                                          domicile: regP.domicileController.text.toString(),
                                          gender: dropDownProvider.selectedGender.toString(),
                                          jobTitle: regP.jobTitleController.text.toString(),
                                          qualification: regP.qualificationController.text.toString(),
                                          registrationID: regP.registrationNumberController.text.toString(),
                                          teacherCNIC: regP.cNICController.text.toString(),
                                          teacherClass: dropDownProvider.selectedClass.toString(),
                                          teacherContact: regP.contactController.text.toString(),
                                          teacherFatherName: regP.fatherNameController.text.toString(),
                                          teacherImage: imageUrl.toString(),
                                          pdfImageUrl: regP.pdfImageUrlController.text.toString(),
                                          teacherName: regP.nameController.text.toString(),
                                          teacherSubject: dropDownProvider.selectedGroup,
                                          timestamp: DateTime.now().millisecondsSinceEpoch.toString()
                                      );

                                      await regP.uploadStudentData(_model);
                                      regP.resetControllers();
                                      ActionProvider.stopLoading();
                                      dropDownProvider.clear();
                                    }

                                  }, width: 200.0, height: 50.0),
                                  const SizedBox(width: 10.0,),
                                  ButtonWidget(
                                    index: 3,
                                    text: "Clear",
                                    width: 200.0,
                                    height: 50.0,
                                    onClicked: () async{

                                      dropDownProvider.clear();
                                      regP.resetControllers();
                                      imageProvider.clear();

                                    },
                                  ),
                                  const SizedBox(width: 10.0,),
                                ],
                              ),
                            ],
                          );
                        },
                      ),


                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: Provider.of<PickerProvider>(context, listen: false).selectedDate,
      firstDate: DateTime(1980),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      Provider.of<PickerProvider>(context, listen: false).selectDate(picked);
    }
  }


}
