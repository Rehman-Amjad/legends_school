import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/component/menu.dart';
import '../../provider/menu/menu_provider.dart';
import '../../responsive.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context)) _buildMenu(),
            Expanded(
              flex: 8,
              child: Consumer<MenuProvider>(
                builder: (context, menuProvider, child) {
                  return menuProvider.selectedScreen; // Display selected screen
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildMenu() {
    return Expanded(
      flex: 2,
      child: SizedBox(
        height: double.infinity,
        child: Menu(scaffoldKey: _scaffoldKey),
      ),
    );
  }
  Widget _buildDrawer(BuildContext context) {
    if (!Responsive.isDesktop(context)) {
      return SizedBox(width: 250, child: Menu(scaffoldKey: _scaffoldKey));
    }
    return const SizedBox.shrink();
  }
}
