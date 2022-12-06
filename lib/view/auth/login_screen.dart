// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noteapp/core/fiunctions/showtost.dart';
import 'package:provider/provider.dart';

import 'package:noteapp/controllers/auth/logincontroller.dart';
import 'package:noteapp/controllers/sizecontroler.dart';
import 'package:noteapp/core/constants/const_color.dart';
import 'package:noteapp/core/fiunctions/myvalidator.dart';
import 'package:noteapp/core/fiunctions/mywillpopscope.dart';
import 'package:noteapp/core/locale/mylocale.dart';
import 'package:noteapp/core/statusrequest.dart';
import 'package:noteapp/view/basic%20widget/loading_widget.dart';

import '../../core/fiunctions/handle_failure.dart';
import '../basic widget/customsizebox.dart';
import 'authWidget.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LogInControlerImp(),
      builder: (context, child) => Consumer<LogInControlerImp>(
        builder: (context, controler, child) {
          return WillPopScope(
            onWillPop: () {
              return myWillPopScopedialog(context);
            },
            child: Scaffold(
                backgroundColor: ConstColor.myBluemmain,
                body: handligStatus(context, controler)),
          );
        },
      ),
    );
  }
}

Widget handligStatus(BuildContext context, LogInControlerImp controler) {
  debugPrint(controler.statusRequest.toString());
  if (controler.statusRequest == StatusRequest.loading) {
    return const LoadingWidgte();
  }
  if (controler.itisFailure(controler.statusRequest)) {
    debugPrint("fail state");
    return FailureState(
        failure: controler.statusRequest,
        functiononpresscancel: () {
          controler.initStatus();
        },
        itiscreateorlogin: false);
  }
  if (controler.statusRequest == StatusRequest.sucsses) {
    debugPrint("sucsess state");
    Future.delayed(Duration.zero, () {
      Timer(
        const Duration(seconds: 1),
        () => controler.gotoHome(context),
      );
      ShowToastCustom(context,
          toasttype: Toasttype.sucsess, title: "LogIn Sucsessfly", body: "");
    });
  }
  return LogInInitState(controler: controler);
}

// ignore: must_be_immutable
class LogInInitState extends StatelessWidget {
  LogInControlerImp controler;
  LogInInitState({required this.controler, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TitleWidget(
          itiscreateaccount: false,
          title: "Sing Up".tr(context),
          backgroundcolor: ConstColor.myBluemmain,
          width: context.read<SizeControler>().widthLocal(context),
          hieght: context.read<SizeControler>().HieghtLocal(context) / 4,
          maincolor: Colors.white,
          assetpath: 'lib/assets/image/mann.png',
        ),
        Form(
          child: Column(
            children: [
              //!email input
              TextFormfeildCustom(
                icon: "lib/assets/image/email.json",
                hinttext: "email".tr(context),
                textcontroller: controler.email,
                validator: (_) => myValidator(
                    context, controler.email.text, 5, 50, 'username'),
              ),
              CustomSizeBox(type: 4),
              //!password input
              TextFormfeildCustom(
                isobsecure: controler.issecure,
                ontap: () {
                  controler.changeIssecure();
                },
                icon: "lib/assets/image/password.json",
                hinttext: "password".tr(context),
                textcontroller: controler.password,
                validator: (_) => myValidator(
                    context, controler.password.text, 5, 50, 'password'),
              ),
              CustomSizeBox(type: 7),
              InkWell(
                onTap: () {
                  controler.login(context);
                },
                child: Container(
                    height:
                        context.read<SizeControler>().HieghtLocal(context) / 15,
                    width:
                        context.read<SizeControler>().widthLocal(context) / 3,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(174, 158, 158, 158)),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 150,
                              color: Colors.black,
                              offset: Offset(1, 3))
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: Center(child: Text('Login'.tr(context)))),
              ),
              CustomSizeBox(type: 5),
              Center(
                child: TextButton(
                  onPressed: () {
                    controler.gotoCreateAccount(context);
                  },
                  child: Text(
                    "dont have accout ... create one".tr(context),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
