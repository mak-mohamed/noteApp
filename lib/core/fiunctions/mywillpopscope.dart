import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/core/constants/const_color.dart';
import 'package:noteapp/core/locale/mylocale.dart';

Future<bool> myWillPopScopedialog(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.bottomSlide,
    title: "warning".tr(context),
    desc: "exiet from app".tr(context),
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      exit(0);
    },
    barrierColor: ConstColor.myBluemmain,
    btnCancelColor: const Color.fromARGB(255, 190, 181, 181),
    btnOkColor: const Color.fromARGB(255, 190, 181, 181),
  ).show();
  return Future(() => true);
}


