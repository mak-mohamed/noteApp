import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

enum Toasttype { sucsess, error, warning, info, delete }

// ignore: non_constant_identifier_names
ShowToastCustom(BuildContext context,
    {required Toasttype toasttype,
    required String title,
    required String body}) {
  switch (toasttype) {
    case Toasttype.sucsess:
      return MotionToast.success(
        title: Text(title),
        description: Text(body),
      ).show(context);

    case Toasttype.warning:
      return MotionToast.warning(
        title: Text(title),
        description: Text(body),
      ).show(context);

    case Toasttype.info:
      return MotionToast.info(
        title: Text(title),
        description: Text(body),
      ).show(context);

    case Toasttype.error:
      return MotionToast.error(
        title: Text(title),
        description: Text(body),
      ).show(context);

    case Toasttype.delete:
      return MotionToast.delete(
        title: Text(title),
        description: Text(body),
      ).show(context);
  }
}
