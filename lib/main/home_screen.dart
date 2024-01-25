import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/helper/my_color.dart';
import 'package:legends_schools_admin/main/admission_form_screen.dart';

import '../helper/container_helper.dart';
import '../helper/image_path.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().lightGrey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Text("")),
                Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentAdmissionFormScreen()));
                      },
                      child: ContainerHelper().dashContainerMenu(20, MediaQuery.sizeOf(context).width,
                          100, ImagePath().studentImagePath, "Admission Form"),
                    )
                ),
                Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>VehicleRegistrationScreen()));
                      },
                      child: ContainerHelper().dashContainerMenu(20, MediaQuery.sizeOf(context).width,
                          100, ImagePath().adminImagePath, "admin"),
                    )
                ),
                Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>HudaiRegistrationScreen()));
                      },
                      child: ContainerHelper().dashContainerMenu(20, MediaQuery.sizeOf(context).width,
                          100, ImagePath().adminImagePath, "admin"),
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Text("")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
