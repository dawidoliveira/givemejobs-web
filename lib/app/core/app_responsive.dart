import 'package:flutter/material.dart';

class AppResponsive {
  AppResponsive._();

  static bool isWeb(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1460) {
      return false;
    }
    return true;
  }
}
