import 'package:flutter/material.dart';
import 'package:noteapp/controllers/homecontroler.dart';
import 'package:noteapp/core/constants/const_color.dart';
import 'package:noteapp/view/basic%20widget/customsizebox.dart';
import 'package:provider/provider.dart';
import '../../controllers/sizecontroler.dart';
import '../../core/fiunctions/getstorange.dart';
import '../../core/fiunctions/mywillpopscope.dart';
import '../../model/user_model.dart';
import 'homescreenwidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HomeControlerImp(
            user: User(
                userid: MyGetstorange.readData("user_id"),
                name: MyGetstorange.readData("user_name") ?? "",
                email: MyGetstorange.readData("user_email") ?? "",
                password: MyGetstorange.readData("user_password") ?? "",
                image: null)),
        child: const Homescreen());
  }
}

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controler = Provider.of<HomeControlerImp>(context);
    return WillPopScope(
      onWillPop: () {
        return myWillPopScopedialog(context);
      },
      child: Scaffold(
        backgroundColor: ConstColor.myBluemmain,
        body: CustomScrollView(
          slivers: <Widget>[
            HomePageAppbar(context, controler),
            homepagebody(context, controler)
          ],
        ),
      ),
    );
  }
}

Widget homepagebody(BuildContext contex, HomeControlerImp controler) {
  return SliverList(
      delegate: SliverChildListDelegate([
    Container(
        decoration: BoxDecoration(
            color: Theme.of(contex).backgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35))),
        height: SizeControler().HieghtLocal(contex),
        child: Column(children: [
          CustomSizeBox(type: 4),
          MainButtons(controler: controler),
          CustomSizeBox(type: 3),
          NewestNotes(
            controler: controler,
          )
        ]))
  ]));
}
