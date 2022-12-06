import 'package:flutter/material.dart';
import 'package:noteapp/controllers/sizecontroler.dart';
import 'package:noteapp/core/constants/const_color.dart';
import 'package:noteapp/core/fiunctions/myvalidator.dart';
import 'package:noteapp/core/locale/mylocale.dart';
import 'package:noteapp/core/statusrequest.dart';
import 'package:noteapp/view/basic%20widget/loading_widget.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth/creataccount_controller.dart';
import '../../core/fiunctions/handle_failure.dart';
import '../basic widget/customsizebox.dart';
import 'authWidget.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateAccountControlerImp(),
      builder: (context, child) {
        return Consumer<CreateAccountControlerImp>(
            builder: (context, controler, child) {
          return Scaffold(
              backgroundColor: ConstColor.myBluemmain,
              body: handlingStatus(controler, context));
        });
      },
    );
  }
}

class CreateAccountInitState extends StatelessWidget {
  final CreateAccountControlerImp controler;

  const CreateAccountInitState({super.key, required this.controler});

  @override
  Widget build(
    BuildContext context,
  ) {
    return ListView(
      children: [
        TitleWidget(
          pickimagefile: controler.image,
          ontap: () {
            controler.pickimage(context);
          },
          itiscreateaccount: true,
          title: "Create Account".tr(context),
          backgroundcolor: ConstColor.myBluemmain,
          width: context.read<SizeControler>().widthLocal(context),
          hieght: context.read<SizeControler>().HieghtLocal(context) / 4,
          maincolor: Colors.white,
          assetpath: 'lib/assets/image/mann.png',
        ),
        Form(
          key: controler.globalKey,
          child: Column(
            children: [
              //!email input
              TextFormfeildCustom(
                icon: "lib/assets/image/email.json",
                hinttext: "Email".tr(context),
                textcontroller: controler.email,
                validator: (_) =>
                    myValidator(context, controler.email.text, 10, 50, 'email'),
              ),
              CustomSizeBox(type: 0),
              //!username input
              TextFormfeildCustom(
                icon: "lib/assets/image/user.json",
                hinttext: "username".tr(context),
                textcontroller: controler.username,
                validator: (_) => myValidator(
                    context, controler.username.text, 5, 50, 'username'),
              ),
              CustomSizeBox(type: 0),
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
              CustomSizeBox(type: 0),
              //! re password input
              TextFormfeildCustom(
                isobsecure: controler.issecure,
                ontap: () {
                  controler.changeIssecure();
                },
                icon: "lib/assets/image/password.json",
                hinttext: " repassword".tr(context),
                textcontroller: controler.repassword,
                validator: (_) => myvalidatorConfirmPassword(context,
                    controler.repassword.text, controler.password.text),
              ),
              CustomSizeBox(type: 0),
              InkWell(
                onTap: () {
                  controler.createaccount(context);
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
                    child: Center(child: Text('create account'.tr(context)))),
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget? handlingStatus(
    CreateAccountControlerImp controler, BuildContext context) {
  if (controler.statusRequest == StatusRequest.loading) {
    return const LoadingWidgte();
  }
  if (controler.statusRequest == StatusRequest.sucsses) {
    Future.delayed(Duration.zero, () {
      controler.gotoSingUp(context);
    });
  }
  if (controler.itisFailure(controler.statusRequest)) {
    debugPrint('we in fail state');
    return FailureState(
      failure: controler.statusRequest,
      functiononpresscancel: () => controler.initStatus(),
      itiscreateorlogin: true,
    );
  }

  return CreateAccountInitState(
    controler: controler,
  );
}
