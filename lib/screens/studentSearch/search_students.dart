import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/component/my_input_field.dart';
import '../../constant.dart';

class SearchStudents extends StatefulWidget {
  const SearchStudents({Key? key}) : super(key: key);

  @override
  State<SearchStudents> createState() => _SearchStudentsState();
}

class _SearchStudentsState extends State<SearchStudents> {
  var searchController = TextEditingController();
  String value = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Students"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            MyCustomInputField(
              'Search',
              'Search any student',
              searchController,
              onChange: (value) => setState(() {}),
            ),
            const SizedBox(
              height: 30,
            ),
            searchController.text.isNotEmpty
                ? SizedBox(
                    width: Get.size.width,
                    height: Get.size.height * .7,
                    child: StreamBuilder(
                      stream: firestore
                          .collection("StudentRegistration")
                          .where('studentName',
                              isEqualTo: searchController.text.trim())
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index];
                              return Text(data['studentName']);
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
