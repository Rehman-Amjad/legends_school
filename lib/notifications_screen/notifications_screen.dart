import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/home_controller.dart';
import '../utils/firebase.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  TextEditingController messageController = TextEditingController();
  String id = '';

  String adminToken = "";

  String adminId = 'WVRpgpBpgqROWjKPrZz5fvQ3ANW2';
  var auth = FirebaseAuth.instance;

  File? image;

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
                child: Row(
              children: [
                SizedBox(
                  width: size.width * .5,
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: size.height * .33,
                        child: StreamBuilder(
                            stream: firestore
                                .collection('liveChat')
                                .where('sendMessage', isEqualTo: 'Yes')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!.docs.isNotEmpty
                                    ? ListView.builder(
                                        padding: const EdgeInsets.all(0),
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (_, index) {
                                          var data = snapshot.data!.docs[index];
                                          return notifyMethod(
                                              press: () {
                                                id = data.id;
                                                controller.getUserName(
                                                    data['senderName']);
                                              },
                                              sender: data['sender'],
                                              title: data['senderName']);
                                        })
                                    : const Center(
                                        child: Text('No Chat Available'),
                                      );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                id == ''
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: SizedBox(
                          width: size.width * .35,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.67,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      controller.name,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: size.height * .6,
                                      width: MediaQuery.of(context).size.width,
                                      child: StreamBuilder(
                                          stream: firestore
                                              .collection('liveChat')
                                              .doc(id)
                                              .collection('chat')
                                              .orderBy('time', descending: true)
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (snapshot.hasData) {
                                              return snapshot.data!.docs.isEmpty
                                                  ? const Center(
                                                      child: Text(
                                                          'No data available'))
                                                  : ListView.builder(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      reverse: true,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      itemCount: snapshot
                                                          .data!.docs.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var ds = snapshot
                                                            .data!.docs[index];
                                                        return Column(
                                                            children: [
                                                              ds["sender"] ==
                                                                      'Yes'
                                                                  ? Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        ds['type'] ==
                                                                                0
                                                                            ? Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 250,
                                                                                    padding: const EdgeInsets.all(15),
                                                                                    margin: const EdgeInsets.all(5),
                                                                                    decoration: BoxDecoration(
                                                                                        color: Colors.green,
                                                                                        boxShadow: [
                                                                                          BoxShadow(
                                                                                            color: Colors.black.withOpacity(.9),
                                                                                            offset: const Offset(-1, 1),
                                                                                            blurRadius: 2,
                                                                                          ),
                                                                                        ],
                                                                                        borderRadius: const BorderRadius.only(
                                                                                          bottomRight: Radius.circular(20),
                                                                                          topRight: Radius.circular(20),
                                                                                          bottomLeft: Radius.circular(20),
                                                                                        )),
                                                                                    child: Text(
                                                                                      ds['content'],
                                                                                      style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.w600,
                                                                                      ),
                                                                                      softWrap: true,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    ds['time'],
                                                                                    style: const TextStyle(
                                                                                      color: Colors.blueGrey,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            : Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 250,
                                                                                    height: 250,
                                                                                    margin: const EdgeInsets.all(5),
                                                                                    padding: const EdgeInsets.all(15),
                                                                                    decoration: BoxDecoration(
                                                                                      image: DecorationImage(image: NetworkImage(ds['image'])),
                                                                                      color: Colors.blueGrey,
                                                                                      boxShadow: [
                                                                                        BoxShadow(
                                                                                          color: Colors.black.withOpacity(.9),
                                                                                          offset: const Offset(-1, 1),
                                                                                          blurRadius: 2,
                                                                                        ),
                                                                                      ],
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    ds['time'],
                                                                                    style: const TextStyle(
                                                                                      color: Colors.blueGrey,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                    softWrap: true,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                      ],
                                                                    )
                                                                  : Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        ds['type'] ==
                                                                                0
                                                                            ? Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 250,
                                                                                    padding: const EdgeInsets.all(15),
                                                                                    margin: const EdgeInsets.all(5),
                                                                                    decoration: BoxDecoration(
                                                                                        color: Colors.deepOrangeAccent,
                                                                                        boxShadow: [
                                                                                          BoxShadow(
                                                                                            color: Colors.black.withOpacity(.9),
                                                                                            offset: const Offset(-1, 1),
                                                                                            blurRadius: 2,
                                                                                          ),
                                                                                        ],
                                                                                        borderRadius: const BorderRadius.only(
                                                                                          topLeft: Radius.circular(20),
                                                                                          bottomRight: Radius.circular(20),
                                                                                          bottomLeft: Radius.circular(20),
                                                                                        )),
                                                                                    child: Text(
                                                                                      ds['content'],
                                                                                      style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.w600,
                                                                                      ),
                                                                                      softWrap: true,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    ds['time'],
                                                                                    style: const TextStyle(
                                                                                      color: Colors.blueGrey,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                    softWrap: true,
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            : Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 250,
                                                                                    height: 250,
                                                                                    margin: const EdgeInsets.all(5),
                                                                                    padding: const EdgeInsets.all(15),
                                                                                    decoration: BoxDecoration(
                                                                                      image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(ds['image'])),
                                                                                      color: Colors.blueGrey,
                                                                                      boxShadow: [
                                                                                        BoxShadow(
                                                                                          color: Colors.black.withOpacity(.9),
                                                                                          offset: const Offset(-1, 1),
                                                                                          blurRadius: 2,
                                                                                        ),
                                                                                      ],
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    ds['time'],
                                                                                    style: const TextStyle(
                                                                                      color: Colors.blueGrey,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                    softWrap: true,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                      ],
                                                                    ),
                                                            ]);
                                                      });
                                            } else if (snapshot.hasError) {
                                              return const Center(
                                                  child: Icon(
                                                      Icons.error_outline));
                                            } else {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width * .29,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                              child: Material(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.red.shade100,
                                            elevation: 5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 2,
                                                horizontal: 20,
                                              ),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText: "write a message",
                                                  hintStyle: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  suffixIcon: IconButton(
                                                      onPressed: () async {
                                                        await controller
                                                            .pickImageMethod()
                                                            .whenComplete(
                                                                () {});

                                                        if (controller
                                                                .pickedImage !=
                                                            null) {
                                                          final ref = FirebaseStorage
                                                              .instance
                                                              .ref(
                                                                  'liveChat/doc/${auth.currentUser!.uid}')
                                                              .child(DateTime
                                                                      .now()
                                                                  .toString());
                                                          var uploadTask =
                                                              await ref.putData(
                                                                  controller
                                                                      .pickedImage!);
                                                          var imageUrl =
                                                              await uploadTask
                                                                  .ref
                                                                  .getDownloadURL();
                                                          debugPrint(imageUrl);
                                                          await firestore
                                                              .collection(
                                                                  'liveChat')
                                                              .doc(id)
                                                              .collection(
                                                                  'chat')
                                                              .add({
                                                            "senderId": id,
                                                            "receiverId":
                                                                adminId,
                                                            'content': '',
                                                            'visibility':
                                                                'True',
                                                            'date': DateFormat
                                                                    .yMMMd()
                                                                .format(DateTime
                                                                    .now()),
                                                            'time': DateFormat(
                                                                    "KK:mm:ss a")
                                                                .format(DateTime
                                                                    .now()),
                                                            'image': imageUrl,
                                                            'sender': 'No',
                                                            'type': 1,
                                                          });
                                                        }
                                                      },
                                                      icon: const Icon(
                                                        Icons.photo,
                                                      )),
                                                ),
                                                controller: messageController,
                                              ),
                                            ),
                                          ))
                                        ]),
                                  ),
                                  MaterialButton(
                                    shape: const CircleBorder(),
                                    color: Colors.deepOrangeAccent,
                                    onPressed: () {
                                      sendMessage(
                                          messageController.text.trim(), 0);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            )),
          );
        });
  }

  void sendMessage(String content, int type) async {
    if (content.trim() != '') {
      messageController.clear();
      await firestore.collection('liveChat').doc(id).collection('chat').add({
        "senderId": id,
        "receiverId": adminId,
        'content': content,
        'sender': 'No',
        'visibility': 'True',
        'date': DateFormat.yMMMd().format(DateTime.now()),
        'time': DateFormat("KK:mm:ss a").format(DateTime.now()),
        'type': type,
      });
    }
  }

  notifyMethod(
      {required String title,
      required Function() press,
      required String sender}) {
    var size = Get.size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        height: size.height * .08,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(-2, 2),
                  blurRadius: 5,
                  color: Colors.grey.withOpacity(.5))
            ]),
        child: ListTile(
          onTap: press,
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notifications),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              sender,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent),
            ),
          ),
        ),
      ),
    );
  }

  messageCounterMethod({required String title, required String counter}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            alignment: Alignment.center,
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.deepOrangeAccent),
            child: Text(
              counter,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
