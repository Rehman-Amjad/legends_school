import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../config/component/app_text_field.dart';
import '../../config/component/app_text_widget.dart';
import '../../config/component/button_widget.dart';
import '../../config/res/app_assets.dart';
import '../../config/util/app_utils.dart';
import '../../constant.dart';
import '../../provider/constant/action_provider.dart';

class PopupAnnoucementScreen extends StatefulWidget {
  const PopupAnnoucementScreen({Key? key}) : super(key: key);

  @override
  _PopupAnnoucementScreenState createState() => _PopupAnnoucementScreenState();
}

class _PopupAnnoucementScreenState extends State<PopupAnnoucementScreen> {
  var tasktext = "Schdeule your annoucement to App Users";

  var titleController = new TextEditingController();
  var typeController = new TextEditingController();
  var messageController = new TextEditingController();

  FirebaseFirestore firestoredatabase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        backgroundColor: primaryColor,
        title: AppTextWidget(
          text: "Announcement",
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: AlignmentDirectional.center,
                height: 150,
                child: Image.asset(AppAssets.logo),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                child: AppTextWidget(
                 text: tasktext,
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child:
                    AppTextField(
                      labelText: "Title",
                        controller: titleController,
                        hintText: "Enter Title"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: AppTextField(
                        labelText: "Announcement Type",
                        controller: typeController,
                        hintText: "Announcement Type"),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 600,
                    child: AppTextField(
                        labelText: "Message",
                        controller: messageController,
                        maxLine: 10,
                        hintText: "Message"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWidget(
                    width: 600,
                      text: "Send Announcement",
                      onClicked: () async{
                        tasktext = "please wait";
                        ActionProvider.startLoading();
                        sendAnnoucement();
                  }),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  void sendAnnoucement() async {
    var today = DateTime.now();
    var dateFormat = DateFormat('dd-MM-yyyy');

    // var  onlyYear = DateFormat('yyyy');
    // var  onlyMonth = DateFormat('MM');
    String currentDate = dateFormat.format(today);
    String currentTime = DateFormat("hh:mm:ss a").format(DateTime.now());

    await firestoredatabase
        .collection("Annoucement")
        .doc("currentAnnoucement")
        .set({
      "title": titleController.text.toUpperCase(),
      "type": typeController.text.toUpperCase(),
      "message": messageController.text,
      "isAnnoucementActive": "true",
      "date": currentDate,
      "time": currentTime,
    }).whenComplete(() {
      setState(() {
        tasktext = "successfully published";
      });
      ActionProvider.startLoading();
      AppUtils().showToast(
          text: "Announcement Send Successfully",

      );
    });
  }
}
