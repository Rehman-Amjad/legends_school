import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/res/app_assets.dart';
import 'package:legends_schools_admin/config/component/scheduled.dart';
import 'package:legends_schools_admin/config/component/weightHeightBloodCard.dart';

import '../../../constant.dart';
import '../../../responsive.dart';

class HomeProfileWidget extends StatelessWidget {
  const HomeProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Responsive.isMobile(context) ? 10 : 30.0),
          topLeft: Radius.circular(Responsive.isMobile(context) ? 10 : 30.0),
        ),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(
                height:   50,
              ),
              Image.asset(
                AppAssets.logo,
                width: 150.0,
                height: 150.0,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Legend School System",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 2,
              ),
             const Text(
                "Director",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(Responsive.isMobile(context) ? 15 : 20.0),
                child: const WeightHeightBloodCard(),
              ),
              SizedBox(
                height: Responsive.isMobile(context) ? 20 : 40,
              ),
              Scheduled()
            ],
          ),
        ),
      ),
    );
  }
}
