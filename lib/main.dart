import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:legends_schools_admin/provider/constant/action_provider.dart';
import 'package:legends_schools_admin/provider/constant/drop_down_provider.dart';
import 'package:legends_schools_admin/provider/constant/picker_provider.dart';
import 'package:legends_schools_admin/provider/global/global_access_provider.dart';
import 'package:legends_schools_admin/provider/menu/menu_provider.dart';
import 'package:legends_schools_admin/provider/registration/form_id_provider.dart';
import 'package:legends_schools_admin/provider/registration/registration_provider.dart';
import 'package:legends_schools_admin/provider/stream/stream_data_provider.dart';
import 'package:legends_schools_admin/routes/routes.dart';
import 'package:legends_schools_admin/routes/routes_name.dart';
import 'package:legends_schools_admin/screens/dashboard/dashboard.dart';
import 'package:legends_schools_admin/screens/drawer/drawer_screen.dart';
import 'package:provider/provider.dart';
import 'constant.dart';
import 'firebase_options.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
           ChangeNotifierProvider(create: (_) => MenuProvider()),
           ChangeNotifierProvider(create: (_) => ActionProvider()),
           ChangeNotifierProvider(create: (_) => StreamDataProvider()),
           ChangeNotifierProvider(create: (_) => DropdownProvider()),
           ChangeNotifierProvider(create: (_) => FormIdProvider()),
           ChangeNotifierProvider(create: (_) => RegistrationProvider()),
           ChangeNotifierProvider(create: (_) => PickerProvider()),
        ],
        child: GetMaterialApp(
          title: 'Legend School System',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: ThemeData(
              primaryColor: MaterialColor(
                primaryColorCode,
                <int, Color>{
                  50: const Color(primaryColorCode).withOpacity(0.1),
                  100: const Color(primaryColorCode).withOpacity(0.2),
                  200: const Color(primaryColorCode).withOpacity(0.3),
                  300: const Color(primaryColorCode).withOpacity(0.4),
                  400: const Color(primaryColorCode).withOpacity(0.5),
                  500: const Color(primaryColorCode).withOpacity(0.6),
                  600: const Color(primaryColorCode).withOpacity(0.7),
                  700: const Color(primaryColorCode).withOpacity(0.8),
                  800: const Color(primaryColorCode).withOpacity(0.9),
                  900: const Color(primaryColorCode).withOpacity(1.0),
                },
              ),
              scaffoldBackgroundColor: customGrey,
              fontFamily: 'IBMPlexSans',
              brightness: Brightness.light
          ),
          initialRoute: RoutesName.splash,
          getPages: Routes.routes,
          builder: EasyLoading.init(),
        ),
      );
    });
  }
}
