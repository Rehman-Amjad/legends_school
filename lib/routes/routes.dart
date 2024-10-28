import 'package:get/get.dart';
import 'package:legends_schools_admin/routes/routes_name.dart';
import 'package:legends_schools_admin/screens/drawer/drawer_screen.dart';
import 'package:legends_schools_admin/screens/start/login_screen.dart';
import 'package:legends_schools_admin/screens/start/splash_screen.dart';

class Routes{

  static final routes = [
    GetPage(name: RoutesName.splash, page: () => const StartScreen()),
    GetPage(name: RoutesName.loginScreen, page: () => const LoginScreen()),
    GetPage(name: RoutesName.drawerScreen, page: () =>  DrawerScreen()),
  ];

}