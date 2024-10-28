import 'package:flutter/cupertino.dart';
import 'package:legends_schools_admin/provider/menu/menu_provider.dart';
import 'package:provider/provider.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class GlobalProviderAccess {

  static MenuProvider? get menuProvider {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<MenuProvider>(context, listen: false);
    }
    return null;
  }


}