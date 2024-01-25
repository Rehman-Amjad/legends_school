

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/helper/my_color.dart';

class ContainerHelper{

  var whiteColor = MyColor().whiteColor;

  Container dashContainerMenu(double radius,double width,double height,String imagepath,String label)
  {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: MyColor().mainColor
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width,
            height: height,
            margin: const EdgeInsets.only(top: 10),
            child: Image.asset(imagepath),
          ),
          const SizedBox(height: 10,),
          Container(
              margin: EdgeInsets.only(top: 10,bottom: 10),
              child: Text(label,style:const TextStyle(
                  fontSize: 16,fontWeight: FontWeight.bold,
                  color: Colors.white
              ),))
        ],
      ),
    );
  }

  Container containerButton(double width, double height, String label, Color color)
  {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
          fontWeight: FontWeight.w500
        ),
        ),
      ),
    );
  }


}