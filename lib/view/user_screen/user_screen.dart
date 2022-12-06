import 'package:flutter/material.dart';
import 'package:noteapp/controllers/auth/userPage_controller.dart';
import 'package:noteapp/controllers/sizecontroler.dart';
import 'package:noteapp/view/basic%20widget/customsizebox.dart';
import 'package:provider/provider.dart';

import '../../core/constants/const_api.dart';
import '../../model/user_model.dart';

class UserScreen extends StatelessWidget {
  final User user;

  const UserScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserControlerImp(),
      child: Scaffold(
          body: Stack(
        children: [
          BackgroundUserPage(user: user),
          UserPageInformation(user: user),
        ],
      )),
    );
  }
}

class UserPageInformation extends StatelessWidget {
  final User user;
  const UserPageInformation({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserControlerImp>(builder: (context, controler, child) {
      Future.delayed(Duration.zero, () => controler.startanimated(context));
      return SizedBox(
        height: SizeControler().HieghtLocal(context),
        width: SizeControler().widthLocal(context),
        child: ListView(children: [
          CustomSizeBox(type: 5),
          Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeIn,
                  width: controler.animatedimagehieght,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(150)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: user.image != null
                          ? Image.network(
                              ConstApi.constimageroute + user.image!,
                              width: controler.animatedimagehieght,
                              height: controler.animatedimagehieght,
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              width: controler.animatedimagehieght,
                              "lib/assets/image/mann.png")),
                )),
          ),
          CustomSizeBox(type: 4),
          CustomAnimatedContainer(
              title: "User Name", body: user.name, controler: controler),
          CustomSizeBox(type: 1),
          CustomAnimatedContainer(
              title: " Email ", body: user.email, controler: controler),
          CustomSizeBox(type: 1),
        ]),
      );
    });
  }
}

class BackgroundUserPage extends StatelessWidget {
  final User user;
  const BackgroundUserPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [ImageBackground(user: user), const ColorBackground()]);
  }
}

class ColorBackground extends StatelessWidget {
  const ColorBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: SizeControler().HieghtLocal(context),
        width: SizeControler().widthLocal(context),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: SizeControler().HieghtLocal(context) / 2,
                width: SizeControler().widthLocal(context),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromRGBO(15, 66, 76, 1),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                  height: SizeControler().HieghtLocal(context) / 2,
                  width: SizeControler().widthLocal(context),
                  color: const Color.fromRGBO(15, 66, 76, 1)),
            )
          ],
        ));
  }
}

class ImageBackground extends StatelessWidget {
  final User user;
  const ImageBackground({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
        height: SizeControler().HieghtLocal(context),
        width: SizeControler().widthLocal(context),
        cacheHeight: SizeControler().HieghtLocal(context).toInt(),
        cacheWidth: SizeControler().widthLocal(context).toInt(),
        "lib/assets/image/profilepic.jpg",
        fit: BoxFit.fill);
  }
}

class CustomAnimatedContainer extends StatelessWidget {
  final String title;
  final String body;
  final UserControlerImp controler;
  const CustomAnimatedContainer(
      {super.key,
      required this.title,
      required this.body,
      required this.controler});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: Colors.white38, borderRadius: BorderRadius.circular(20)),
        duration: const Duration(milliseconds: 1000),
        height: controler.animatedcontainerhieght,
        curve: Curves.easeIn,
        child: ListTile(
            trailing: const Icon(Icons.edit_outlined),
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            subtitle: Text(
              body,
              style: Theme.of(context).textTheme.bodyText2,
            )),
      ),
    );
  }
}
