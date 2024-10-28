
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_schools_admin/config/component/app_text_widget.dart';
import 'package:legends_schools_admin/provider/constant/action_provider.dart';
import 'package:provider/provider.dart';

import '../../config/component/button_widget.dart';
import '../../config/component/dropdown_head_box.dart';
import '../../config/component/text_field_head_box.dart';
import '../../model/registration_form_model.dart';
import '../../provider/constant/drop_down_provider.dart';
import '../../provider/constant/picker_provider.dart';
import '../../provider/registration/form_id_provider.dart';
import '../../provider/registration/registration_provider.dart';

class AdmissionFormScreen extends StatelessWidget {

  AdmissionFormScreen({super.key});

  var nameController = TextEditingController();
  var fatherNameController = TextEditingController();
  var fatherCNICController = TextEditingController();
  var groupNameController = TextEditingController();
  var schoolNameController = TextEditingController();
  var dailyTestController = TextEditingController();
  var servicesChargesController = TextEditingController();
  var extraChargesController = TextEditingController();
  var discountController = TextEditingController();
  var languageController = TextEditingController();
  var studentReferenceController = TextEditingController();

  var dobController = TextEditingController();
  var religionController = TextEditingController();
  var nationalityController = TextEditingController();
  var addressController = TextEditingController();
  var contactNumberController = TextEditingController();
  var whatsappNumberController = TextEditingController();
  var medicalConditionController = TextEditingController();
  var residenceNumberController = TextEditingController();
  var registrationController = TextEditingController();
  var imageURLController = TextEditingController();

  //subject prices
  var sub1PriceController = TextEditingController();
  var sub2PriceController = TextEditingController();
  var sub3PriceController = TextEditingController();
  var sub4PriceController = TextEditingController();
  var sub5PriceController = TextEditingController();
  var sub6PriceController = TextEditingController();
  var sub7PriceController = TextEditingController();
  var sub8PriceController = TextEditingController();

  final _key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final dropDownProvider = Provider.of<DropdownProvider>(context,listen: false);
    final registrationProvider = Provider.of<RegistrationProvider>(context,listen: false);
    final formProvider = Provider.of<FormIdProvider>(context,listen: false);
    final imageProvider = Provider.of<PickerProvider>(context,listen: false);
    final loadingProvider = Provider.of<ActionProvider>(context,listen: false);

    formProvider.fetchCountValue();
    dailyTestController.text = "0";
    servicesChargesController.text = "0";
    extraChargesController.text = "0";
    discountController.text = "0";
    return Scaffold(
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
               const SizedBox(height: 20.0,),
                AppTextWidget(text: "Students Registration Form", color: Colors.black, fontSize: 18.0),
                const SizedBox(height: 20.0,),
                Container(
                  width: Get.width,
                  padding:const EdgeInsets.all(40.0),
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
                          Consumer<FormIdProvider>(
                            builder: (context,provider,child){
                              return AppTextWidget(text: "Form Number: ${provider.formID}", color: Colors.red, fontSize: 20.0,
                                  fontWeight: FontWeight.bold);
                            },
                          ),

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
                                      const SizedBox(height: 20.0,),
                                      ButtonWidget(text: "Upload", onClicked: (){
                                        provider.pickImage();
                                      }, width: 100.0, height: 50.0,)
                                    ],
                                  );
                                }
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: TextFieldHeadBox(labelText: "Registration No*",hintText: "Registration No",controller: registrationController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Name*",hintText: "Student Name",controller: nameController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Father Name*",hintText: "Father Name",controller: fatherNameController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Father CNIC*",hintText: "Father CNIC",controller: fatherCNICController,),),
                        ],
                      ),
                      const SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child:
                          Consumer<PickerProvider>(
                            builder: (context, provider, child){
                              return TextFieldHeadBox(
                                press: (){
                                  _selectDate(context);
                                },
                                labelText: "Student DOB*",hintText: dobController.text =
                                  provider.dobDate,controller: dobController,);
                            },
                          )
                          ),
                          Expanded(child: TextFieldHeadBox(labelText: "Religion*",hintText: "Religion",controller: religionController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Nationality*",hintText: "Nationality",controller: nationalityController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Medical Condition*",hintText: "Medical Condition",controller: medicalConditionController,),),
                        ],
                      ),

                      const SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: TextFieldHeadBox(labelText: "Language Spoken at Home*",hintText: "Language Spoken at Home",controller: languageController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Contact Number*",hintText: "Contact Number",controller: contactNumberController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Residence Number*",hintText: "Residence Number",controller: residenceNumberController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Whatsapp Number*",hintText: "Whatsapp Number",controller: whatsappNumberController,),),
                        ],
                      ),

                      const SizedBox(height: 20.0,),
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
                                    }, labelText: 'Student Class*',)
                              ),
                              Expanded(
                                  child: DropDownHeadBox(
                                    items: provider.groupList, selectedItem: provider.selectedGroup,
                                    onChanged: (value){
                                      provider.changeGroup(value.toString());
                                    }, labelText: 'Student Group*',)
                              ),
                              Expanded(
                                  child: DropDownHeadBox(
                                    items: provider.academyStatusList, selectedItem: provider.selectAcademyStatus,
                                    onChanged: (value){
                                      provider.changeAcademyStatus(value.toString());
                                    }, labelText: 'Status',)
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: TextFieldHeadBox(labelText: "Student Address*",hintText: "Student Address",controller: addressController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "School Name*",hintText: "School Name",controller: schoolNameController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Any brother(s)/sister(s) already attending the school*",
                            hintText: "Any brother(s)/sister(s) already attending the school",
                            controller: studentReferenceController,),),
                        ],
                      ),

                      const SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: TextFieldHeadBox(labelText: "Image Link For PDF*",hintText: "Image Link For PDF",controller: imageURLController,),),
                          const Expanded(child: SizedBox()),
                          const Expanded(child: SizedBox()),
                          //  Expanded(child: SizedBox()),
                        ],
                      ),

                      const  SizedBox(height: 30.0,),
                      const Divider(),
                      const SizedBox(height: 20.0,),
                      AppTextWidget(text: "Student Courses & Prices", color: Colors.black, fontSize: 18.0,
                      fontWeight: FontWeight.bold,),
                      const SizedBox(height: 20.0,),
                      // const SubjectListDesign(),

                      const SizedBox(height: 30.0,),
                      const Divider(),
                      const SizedBox(height: 20.0,),
                      AppTextWidget(text: "Student Fee Details", color: Colors.black, fontSize: 18.0,
                      fontWeight: FontWeight.bold,),
                      const SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: TextFieldHeadBox(labelText: "Daily Test*",hintText: "Daily Test",controller: dailyTestController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Services Charges*",hintText: "Services Charges",controller: servicesChargesController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Extra Charges*",hintText: "Extra Charges",controller: extraChargesController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Discount%*",hintText: "Discount Charges",controller: discountController,),),
                        ],
                      ),

                      const SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const  Expanded(child: SizedBox()),
                          const  Expanded(child: SizedBox()),
                          const  Expanded(child: SizedBox()),
                          Expanded(child:
                          Consumer<DropdownProvider>(
                            builder: (context, provider, child){
                              return DropDownHeadBox(items: provider.feeStatusList,
                                selectedItem: provider.selectedFeeStatus, onChanged: (String? value) {
                                  provider.changeFeeStatus(value.toString());
                                }, labelText: 'Fee Status',);
                            },
                          )
                          ),
                        ],
                      ),

                      const SizedBox(height: 30.0,),
                      const Divider(),
                      const SizedBox(height: 20.0,),
                      AppTextWidget(text: "Student Fee Plans", color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold,),
                      const SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Consumer<DropdownProvider>(
                              builder: (context, provider, child){
                                return DropDownHeadBox(items: provider.feePlanList,
                                  selectedItem: provider.selectedFeePlan, onChanged: (String? value) {
                                    provider.changeFeePlan(value.toString());
                                  }, labelText: 'Fee Plans',);
                              },
                            ),
                          ),
                          const  Expanded(child: SizedBox()),
                          const  Expanded(child: SizedBox()),
                          const  Expanded(child: SizedBox()),

                        ],
                      ),

                      const  SizedBox(height: 30.0,),
                      Consumer<RegistrationProvider>(
                        builder: (context, provider, child){
                          return  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ButtonWidget(text: "Calculate", onClicked: (){
                                    provider.setTotalDues(((int.parse(dailyTestController.text) +
                                        int.parse(servicesChargesController.text) +
                                        int.parse(extraChargesController.text) +
                                        int.parse(dropDownProvider.subject1Price) +
                                        int.parse(dropDownProvider.subject2Price) +
                                        int.parse(dropDownProvider.subject3Price) +
                                        int.parse(dropDownProvider.subject4Price) +
                                        int.parse(dropDownProvider.subject5Price) +
                                        int.parse(dropDownProvider.subject6Price) +
                                        int.parse(dropDownProvider.subject7Price) +
                                        int.parse(dropDownProvider.subject8Price) +
                                        int.parse(dropDownProvider.subject9Price)) -
                                        int.parse(discountController.text)).toString());

                                    provider.setTotalSubjectFee(
                                        (
                                            int.parse(dropDownProvider.subject1Price) +
                                                int.parse(dropDownProvider.subject2Price) +
                                                int.parse(dropDownProvider.subject3Price) +
                                                int.parse(dropDownProvider.subject4Price) +
                                                int.parse(dropDownProvider.subject5Price) +
                                                int.parse(dropDownProvider.subject6Price) +
                                                int.parse(dropDownProvider.subject7Price) +
                                                int.parse(dropDownProvider.subject8Price) +
                                                int.parse(dropDownProvider.subject9Price)
                                        )
                                            .toString()
                                    );
                                  }, width: 200.0, height: 50.0),
                                  const SizedBox(width: 10.0,),
                                  ButtonWidget(
                                    text: "Preview",
                                    width: 200.0,
                                    height: 50.0,
                                    onClicked: () async{

                                      final student = RegistrationFormModel(
                                        studentFormID: formProvider.formID.toString(),
                                        registrationNumber: registrationController.text.toString(),
                                        studentName: nameController.text.toString(),
                                        studentStatus: dropDownProvider.selectAcademyStatus,
                                        studentFatherName: fatherNameController.text.toString(),
                                        fatherCNIC: fatherCNICController.text.toString(),
                                        studentDOB: dobController.text.toString(),
                                        religion: religionController.text.toString(),
                                        nationality: nationalityController.text.toString(),
                                        medicalCondition: medicalConditionController.text.toString(),
                                        studentAddress: addressController.text.toString(),
                                        schoolName: schoolNameController.text.toString(),
                                        languageSpoken: languageController.text.toString(),
                                        refferranceName: studentReferenceController.text.toString(),
                                        studentImageUrl: imageURLController.text.toString(),
                                        contactNumber: contactNumberController.text.toString(),
                                        whatsappNumber: whatsappNumberController.text.toString(),
                                        residenceNumber: residenceNumberController.text.toString(),
                                        dailyTest: dailyTestController.text.toString(),
                                        servicesFee: servicesChargesController.text.toString(),
                                        extraCharges: extraChargesController.text.toString(),
                                        discountCharges: discountController.text.toString(),
                                        gender: dropDownProvider.selectedGender.toString(),
                                        studentClassName: dropDownProvider.selectedClass.toString(),
                                        studentGroupName: dropDownProvider.selectedGroup.toString(),
                                        feeStatus: dropDownProvider.selectedFeeStatus,
                                        totalDues: registrationProvider.totalDues.toString(),
                                        subject1: dropDownProvider.subject1,
                                        subject2: dropDownProvider.subject2,
                                        subject3: dropDownProvider.subject3,
                                        subject4: dropDownProvider.subject4,
                                        subject5: dropDownProvider.subject5,
                                        subject6: dropDownProvider.subject6,
                                        subject7: dropDownProvider.subject7,
                                        subject8: dropDownProvider.subject8,
                                        subject9: dropDownProvider.subject9,
                                        subject1Price: dropDownProvider.subject1Price,
                                        subject2Price: dropDownProvider.subject2Price,
                                        subject3Price: dropDownProvider.subject3Price,
                                        subject4Price: dropDownProvider.subject4Price,
                                        subject5Price: dropDownProvider.subject5Price,
                                        subject6Price: dropDownProvider.subject6Price,
                                        subject7Price: dropDownProvider.subject7Price,
                                        subject8Price: dropDownProvider.subject8Price,
                                        subject9Price: dropDownProvider.subject9Price,
                                        studentImageProfile: imageProvider.pickedImage.toString(),
                                        totalSubjectFee: registrationProvider.totalSubjectFee.toString(),
                                        feePlan: dropDownProvider.selectedFeePlan.toString(),
                                      );

                                      // RegistrationPdf().generatePDF(context,student);


                                      //  RegistrationPdf().generatePDF(context);
                                      // try{
                                      //   await Printing.layoutPdf(
                                      //     onLayout: (PdfPageFormat format) async => RegistrationPdf().generatePDF(context),
                                      //     name: "pdfFileName",
                                      //   );
                                      // }catch(e){
                                      //   log("/////////////////////////////// ${e.toString()}");
                                      // }finally{
                                      //   log("/////////////////////////////// finally run");
                                      // }

                                    },
                                  ),
                                  const SizedBox(width: 10.0,),
                                  ButtonWidget(text: "Save & Preview", onClicked: () async{
                                    if(_key.currentState!.validate() && imageProvider.pickedImage !=null){
                                      _key.currentState!.save();
                                      loadingProvider.startLoading();
                                      final String imageUrl;
                                      if(imageProvider.pickedImage !=null){
                                        imageUrl = await imageProvider.firebaseStorageImage(image: imageProvider.pickedImage!);
                                      }else{
                                        imageUrl = '';
                                      }


                                      final _students = RegistrationFormModel(
                                        studentFormID: formProvider.formID.toString(),
                                        registrationNumber: registrationController.text,
                                        studentName: nameController.text,
                                        studentStatus: dropDownProvider.selectAcademyStatus,
                                        studentFatherName: fatherNameController.text,
                                        fatherCNIC: fatherCNICController.text,
                                        studentDOB: dobController.text,
                                        religion: religionController.text,
                                        nationality: nationalityController.text,
                                        medicalCondition: medicalConditionController.text,
                                        studentAddress: addressController.text,
                                        schoolName: schoolNameController.text,
                                        languageSpoken: languageController.text,
                                        refferranceName: studentReferenceController.text,
                                        studentImageUrl: imageURLController.text,
                                        contactNumber: contactNumberController.text,
                                        whatsappNumber: whatsappNumberController.text,
                                        residenceNumber: residenceNumberController.text,
                                        dailyTest: dailyTestController.text,
                                        servicesFee: servicesChargesController.text,
                                        extraCharges: extraChargesController.text,
                                        discountCharges: discountController.text,
                                        gender: dropDownProvider.selectedGender.toString(),
                                        studentClassName: dropDownProvider.selectedClass.toString(),
                                        studentGroupName: dropDownProvider.selectedGroup.toString(),
                                        feeStatus: dropDownProvider.selectedFeeStatus,
                                        totalDues: registrationProvider.totalDues.toString(),
                                        subject1: dropDownProvider.subject1,
                                        subject2: dropDownProvider.subject2,
                                        subject3: dropDownProvider.subject3,
                                        subject4: dropDownProvider.subject4,
                                        subject5: dropDownProvider.subject5,
                                        subject6: dropDownProvider.subject6,
                                        subject7: dropDownProvider.subject7,
                                        subject8: dropDownProvider.subject8,
                                        subject9: dropDownProvider.subject9,
                                        subject1Price: dropDownProvider.subject1Price,
                                        subject2Price: dropDownProvider.subject2Price,
                                        subject3Price: dropDownProvider.subject3Price,
                                        subject4Price: dropDownProvider.subject4Price,
                                        subject5Price: dropDownProvider.subject5Price,
                                        subject6Price: dropDownProvider.subject6Price,
                                        subject7Price: dropDownProvider.subject7Price,
                                        subject8Price: dropDownProvider.subject8Price,
                                        subject9Price: dropDownProvider.subject9Price,
                                        studentImageProfile: imageUrl.toString(),
                                        totalSubjectFee: registrationProvider.totalSubjectFee.toString(),
                                        feePlan: dropDownProvider.selectedFeePlan.toString(),
                                      );
                                      registrationProvider.updateStudent(_students);
                                      await registrationProvider.uploadStudentData();
                                      await formProvider.updateCountValue(formID: int.parse(formProvider.formID.toString()).toString());
                                      loadingProvider.stopLoading();
                                      dropDownProvider.clear();


                                      // RegistrationPdf().generatePDF(context,_students);
                                    }

                                  }, width: 200.0, height: 50.0),
                                  const  SizedBox(width: 10.0,),
                                  ButtonWidget(
                                    text: "Clear",
                                    width: 200.0,
                                    height: 50.0,
                                    onClicked: () async{

                                      dropDownProvider.clear();
                                      resetAllControllers();
                                      imageProvider.clear();

                                    },
                                  ),
                                  const SizedBox(width: 10.0,),
                                ],
                              ),
                              AppTextWidget(text: "Total Fee: PKR  ${provider.totalDues}", color: Colors.black,
                                  fontSize: 18.0, fontWeight: FontWeight.bold,),
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

  void resetAllControllers() {
    nameController.text = "";
    fatherNameController.text = "";
    fatherCNICController.text = "";
    groupNameController.text = "";
    schoolNameController.text = "";
    dailyTestController.text = "0";
    servicesChargesController.text = "0";
    extraChargesController.text = "0";
    discountController.text = "0";
    languageController.text = "";
    studentReferenceController.text = "";
    dobController.text = "";
    religionController.text = "";
    nationalityController.text = "";
    addressController.text = "";
    contactNumberController.text = "";
    whatsappNumberController.text = "";
    medicalConditionController.text = "";
    residenceNumberController.text = "";
    registrationController.text = "";
    imageURLController.text = "";
    sub1PriceController.text = "";
    sub2PriceController.text = "";
    sub3PriceController.text = "";
    sub4PriceController.text = "";
    sub5PriceController.text = "";
    sub6PriceController.text = "";
    sub7PriceController.text = "";
    sub8PriceController.text = "";
  }


}
