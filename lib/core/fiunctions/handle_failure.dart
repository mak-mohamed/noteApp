import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/core/locale/mylocale.dart';
import 'package:noteapp/core/statusrequest.dart';
import '../constants/const_color.dart';

// ignore: must_be_immutable
class FailureState extends StatelessWidget {
  StatusRequest failure;
  bool itiscreateorlogin;
  void Function() functiononpresscancel;

  FailureState(
      {required this.failure,
      required this.functiononpresscancel,
      required this.itiscreateorlogin,
      super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration.zero,
        () => failureHandking(
            failure, context, functiononpresscancel, itiscreateorlogin));
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: InkWell(onTap: () => functiononpresscancel()),
    );
  }
}

failureHandking(StatusRequest statusRequest, BuildContext context,
    void Function() function, bool itiscreateorlogin) {
  if (statusRequest == StatusRequest.offlineFailuer) {
    return myFailuerDialog(
        context,
        "offline ... please chech your internet connection",
        statusRequest,
        function);
  }
  if (statusRequest == StatusRequest.serverFailuer) {
    return myFailuerDialog(
        context,
        "server failuer ... please chech your internet connection",
        statusRequest,
        function);
  }
  if (statusRequest == StatusRequest.unExpectedFailuer) {
    return myFailuerDialog(context, "unexcepted failuer ... please try later",
        statusRequest, function);
  }
  if (statusRequest == StatusRequest.sucsess_but_no_data && itiscreateorlogin) {
    return myFailuerDialog(
        context,
        "the email already exeist ... please choise another email",
        statusRequest,
        function);
  }
  if (statusRequest == StatusRequest.sucsess_but_no_data &&
      !itiscreateorlogin) {
    return myFailuerDialog(
        context,
        "no account match... please check the email and password",
        statusRequest,
        function);
  }
}

myFailuerDialog(BuildContext context, String message,
    StatusRequest statusRequest, void Function() function) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.bottomSlide,
    title: "warning".tr(context),
    desc: message,
    btnCancelOnPress: () {
      statusRequest = StatusRequest.init;
      function();
    },
    barrierColor: ConstColor.myBluemmain,
    btnCancelColor: const Color.fromARGB(255, 190, 181, 181),
    btnOkColor: const Color.fromARGB(255, 190, 181, 181),
  ).show();
}
