import 'package:flutter/cupertino.dart';
import 'package:noteapp/core/locale/mylocale.dart';

String? myValidator(
    BuildContext context, String? val, int min, int max, String type) {
  if (val != null) {
    if (val.isEmpty) {
      return 'this feild cant be empty'.tr(context);
    }
    if (val.length > max) {
      return 'this feild cant be larger than'.tr(context) + max.toString();
    }
    if (val.length < min) {
      return 'this feild cant be smaler than'.tr(context) + min.toString();
    }
  } else {
    return 'this feild cant be empty'.tr(context);
  }
  return null;
}

String? myvalidatorConfirmPassword(
    BuildContext context, String val, String password) {
  if (val != password) {
    return 'password and confirm must be same'.tr(context);
  }
  return null;
}
