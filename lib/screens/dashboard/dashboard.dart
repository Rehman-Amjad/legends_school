import 'package:flutter/material.dart';
import 'package:legends_schools_admin/constant.dart';
import 'package:legends_schools_admin/screens/dashboard/widget/home_graph_widget.dart';
import '../../responsive.dart';
import 'widget/home_profile_widget.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
            const Expanded(flex: 8, child: HomeGraphWidget()),
            if (!Responsive.isMobile(context)) _buildProfile(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return const Expanded(
      flex: 4,
      child: HomeProfileWidget(),
    );
  }
}
