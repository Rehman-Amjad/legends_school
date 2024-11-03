import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_schools_admin/config/component/app_text_field.dart';
import 'package:legends_schools_admin/config/component/app_text_widget.dart';
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

class AdmissionFormScreen extends StatelessWidget {

  final _key = GlobalKey<FormState>();

  AdmissionFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dropDownProvider = Provider.of<DropdownProvider>(context,listen: false);
    final regP = Provider.of<RegistrationProvider>(context,listen: false);
    final formProvider = Provider.of<FormIdProvider>(context,listen: false);
    final imageProvider = Provider.of<PickerProvider>(context,listen: false);

    formProvider.fetchCountValue();
    regP.dailyTestController.text = "0";
    regP.servicesChargesController.text = "0";
    regP.extraChargesController.text = "0";
    regP.discountController.text = "0";
    return Scaffold(
      appBar: AppBar(
        title: AppTextWidget(text: "Student Registration",
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
                AppTextWidget(text: "Students Registration Form", color: Colors.black,
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
                        offset: Offset(0, 3), // changes position of shadow
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
                              return AppTextWidget(text: "Form Number: ${provider.formID}",
                                  color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold,);
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
                          Expanded(child: TextFieldHeadBox(labelText: "Registration No*",hintText: "Registration No",controller: regP.registrationController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Name*",hintText: "Student Name",controller: regP.nameController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Father Name*",hintText: "Father Name",controller: regP.fatherNameController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Father CNIC*",hintText: "Father CNIC",controller: regP.fatherCNICController,),),
                        ],
                      ),
                      SizedBox(height: 20.0,),
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
                                labelText: "Student DOB*",hintText: regP.dobController.text =
                                  provider.dobDate,controller: regP.dobController,);
                            },
                          )
                          ),
                          Expanded(child: TextFieldHeadBox(labelText: "Religion*",hintText: "Religion",controller: regP.religionController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Nationality*",hintText: "Nationality",controller: regP.nationalityController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Medical Condition*",hintText: "Medical Condition",controller: regP.medicalConditionController,),),
                        ],
                      ),

                      SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: TextFieldHeadBox(labelText: "Student B Form*",hintText: "Student B Form*",controller: regP.bFormController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Contact Number*",hintText: "Contact Number",controller: regP.contactNumberController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Residence Number*",hintText: "Residence Number",controller: regP.residenceNumberController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Whatsapp Number*",hintText: "Whatsapp Number",controller: regP.whatsappNumberController,),),
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
                                    }, labelText: 'Student Class*',)
                              ),
                              Expanded(
                                  child: DropDownHeadBox(
                                    items: provider.groupList, selectedItem: provider.selectedGroup,
                                    onChanged: (value){
                                      provider.changeGroup(value.toString());
                                    }, labelText: 'Father Occupation*',)
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
                          Expanded(child: TextFieldHeadBox(labelText: "Student Address*",hintText: "Student Address",controller: regP.addressController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "School Name*",hintText: "School Name",controller: regP.schoolNameController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Any brother(s)/sister(s) already attending the school*",
                            hintText: "Any brother(s)/sister(s) already attending the school",
                            controller: regP.studentReferenceController,),),
                        ],
                      ),

                      SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: TextFieldHeadBox(labelText: "Image Link For PDF*",hintText: "Image Link For PDF",controller: regP.imageURLController,),),
                          const Expanded(child: SizedBox()),
                         const Expanded(child: SizedBox()),
                          //  Expanded(child: SizedBox()),
                        ],
                      ),

                      SizedBox(height: 30.0,),
                      Divider(),
                      SizedBox(height: 20.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextWidget(text: "Fee", color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold,),
                                  const SizedBox(height: 20.0,),
                                  AppTextField(
                                      controller: regP.feeController,
                                      hintText: "Student Fee"
                                  ),
                                ],
                              )
                          ),
                          const Expanded(child: SizedBox()),
                          const Expanded(child: SizedBox()),
                          //  Expanded(child: SizedBox()),
                        ],
                      ),

                      const SizedBox(height: 30.0,),
                      Divider(),
                      SizedBox(height: 20.0,),
                      AppTextWidget(text: "Student Fee Details", color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold,),
                      SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: TextFieldHeadBox(labelText: "Daily Test*",hintText: "Daily Test",controller: regP.dailyTestController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Services Charges*",hintText: "Services Charges",controller: regP.servicesChargesController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Extra Charges*",hintText: "Extra Charges",controller: regP.extraChargesController,),),
                          Expanded(child: TextFieldHeadBox(labelText: "Discount Charges*",hintText: "Discount Charges",controller:regP. discountController,),),
                        ],
                      ),

                      SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: SizedBox()),
                          Expanded(child: SizedBox()),
                          Expanded(child: SizedBox()),
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

                      SizedBox(height: 30.0,),
                      Divider(),
                      SizedBox(height: 20.0,),
                      AppTextWidget(text: "Student Fee Plans", color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold,),
                      SizedBox(height: 20.0,),
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
                          Expanded(child: SizedBox()),
                          Expanded(child: SizedBox()),
                          Expanded(child: SizedBox()),

                        ],
                      ),

                      SizedBox(height: 30.0,),
                      Consumer<RegistrationProvider>(
                        builder: (context, provider, child){
                          return  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ButtonWidget(
                                      index: 0,
                                      text: "Calculate", onClicked: () async{
                                    provider.setTotalDues(((int.parse(regP.dailyTestController.text) +
                                        int.parse(regP.servicesChargesController.text) +
                                        int.parse(regP.extraChargesController.text) +
                                        int.parse(regP.feeController.text)) -
                                        int.parse(regP.discountController.text)).toString());
                                  }, width: 200.0, height: 50.0),
                                  SizedBox(width: 10.0,),
                                  ButtonWidget(
                                    index: 1,
                                    text: "Preview",
                                    width: 200.0,
                                    height: 50.0,
                                    onClicked: () async{

                                      final student = RegistrationFormModel(
                                        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
                                        formId: formProvider.formID.toString(),
                                        registrationNumber: regP.registrationController.text.toString(),
                                        name:regP. nameController.text.toString(),
                                        status: dropDownProvider.selectedStatus,
                                        fatherName: regP.fatherNameController.text.toString(),
                                        fatherCNIC: regP.fatherCNICController.text.toString(),
                                        studentDOB: regP.dobController.text.toString(),
                                        religion: regP.religionController.text.toString(),
                                        nationality: regP.nationalityController.text.toString(),
                                        medicalCondition: regP.medicalConditionController.text.toString(),
                                        address: regP.addressController.text.toString(),
                                        schoolName: regP.schoolNameController.text.toString(),
                                        referenceName: regP.studentReferenceController.text.toString(),
                                        pdfImageUrl: regP.imageURLController.text.toString(),
                                        contactNumber: regP.contactNumberController.text.toString(),
                                        whatsappNumber: regP.whatsappNumberController.text.toString(),
                                        residenceNumber: regP.residenceNumberController.text.toString(),
                                        dailyTest: regP.dailyTestController.text.toString(),
                                        servicesFee: regP.servicesChargesController.text.toString(),
                                        extraCharges: regP.extraChargesController.text.toString(),
                                        discountCharges: regP.discountController.text.toString(),
                                        bForm: regP.bFormController.text.toString(),
                                        gender: dropDownProvider.selectedGender.toString(),
                                        className: dropDownProvider.selectedClass.toString(),
                                        groupName: dropDownProvider.selectedGroup.toString(),
                                        feeStatus: dropDownProvider.selectedFeeStatus,
                                        totalDues: regP.totalDues.toString(),
                                        profileImage: imageProvider.pickedImage.toString(),
                                        feePlan: dropDownProvider.selectedFeePlan.toString(),
                                        fatherOccupation: '',
                                      );
                                      RegistrationPdf().generatePDF(context,student);
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


                                      final _students = RegistrationFormModel(
                                        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
                                        formId: formProvider.formID.toString(),
                                        registrationNumber: regP.registrationController.text,
                                        name: regP.nameController.text,
                                        status: dropDownProvider.selectedStatus,
                                        fatherName: regP.fatherNameController.text,
                                        fatherCNIC: regP.fatherCNICController.text,
                                        studentDOB: regP.dobController.text,
                                        religion: regP.religionController.text,
                                        nationality: regP.nationalityController.text,
                                        medicalCondition: regP.medicalConditionController.text,
                                        address: regP.addressController.text,
                                        schoolName: regP.schoolNameController.text,
                                        referenceName: regP.studentReferenceController.text,
                                        pdfImageUrl: regP.imageURLController.text,
                                        bForm: regP.bFormController.text,
                                        contactNumber: regP.contactNumberController.text,
                                        whatsappNumber: regP.whatsappNumberController.text,
                                        residenceNumber: regP.residenceNumberController.text,
                                        dailyTest: regP.dailyTestController.text,
                                        servicesFee: regP.servicesChargesController.text,
                                        extraCharges: regP.extraChargesController.text,
                                        discountCharges: regP.discountController.text,
                                        gender: dropDownProvider.selectedGender.toString(),
                                        className: dropDownProvider.selectedClass.toString(),
                                        groupName: dropDownProvider.selectedGroup.toString(),
                                        feeStatus: dropDownProvider.selectedFeeStatus,
                                        totalDues: regP.totalDues.toString(),
                                        profileImage: imageUrl.toString(),
                                        feePlan: dropDownProvider.selectedFeePlan.toString(), fatherOccupation: '',
                                      );
                                      regP.updateStudent(_students);
                                      await regP.uploadStudentData();
                                      await formProvider.updateCountValue(formID: int.parse(formProvider.formID.toString()).toString());
                                      ActionProvider.stopLoading(index: 2);
                                      dropDownProvider.clear();
                                      RegistrationPdf().generatePDF(context,_students);
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
                                      regP.resetAllControllers();
                                      imageProvider.clear();

                                    },
                                  ),
                                  const SizedBox(width: 10.0,),
                                ],
                              ),
                              AppTextWidget(text: "Total Fee: PKR  ${provider.totalDues}", color: Colors.black, fontSize: 18.0),
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
