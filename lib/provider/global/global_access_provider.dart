import 'package:flutter/cupertino.dart';
import 'package:legends_schools_admin/provider/constant/drop_down_provider.dart';
import 'package:legends_schools_admin/provider/fee_management_provider.dart';
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

  static DropdownProvider? get dropdownProvider {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<DropdownProvider>(context, listen: false);
    }
    return null;
  }

  static FeeManagementProvider? get feeManagementProvider {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<FeeManagementProvider>(context, listen: false);
    }
    return null;
  }


}