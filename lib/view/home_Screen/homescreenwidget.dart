import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:noteapp/core/constants/const_api.dart';
import 'package:provider/provider.dart';
import '../../controllers/homecontroler.dart';
import '../../controllers/sizecontroler.dart';
import '../../core/constants/const_color.dart';

//! homepage appbar section 1
// ignore: non_constant_identifier_names
Widget HomePageAppbar(BuildContext contex, HomeControlerImp controler) {
  return SliverAppBar(
      snap: false,
      floating: false,
      expandedHeight: SizeControler().HieghtLocal(contex) / 5,
      pinned: true,
      stretch: true,
      backgroundColor: ConstColor.myBluemmain,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: InkWell(
          onTap: () {
            controler.gotoUserPage(contex);
          },
          child: ListTile(
            //?user image
            leading: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(200)),
                height: SizeControler().HieghtLocal(contex) / 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: SizedBox(
                      height: SizeControler().HieghtLocal(contex) / 15,
                      width: SizeControler().HieghtLocal(contex) / 15,
                      child: controler.thereisimage()
                          ? Image.network(
                              fit: BoxFit.fill,
                              height: SizeControler().HieghtLocal(contex) / 15,
                              ConstApi.constimageroute + controler.user.image!)
                          : Image.asset("lib/assets/image/man.png")),
                )),
            //?user namw
            title: Text(controler.user.name,
                style: Theme.of(contex).textTheme.bodyLarge),
            //?user email
            subtitle: Text(controler.user.email,
                style: Theme.of(contex).textTheme.bodySmall),
          ),
        ),
      ));
}

//! mainButtons section 2
class MainButtons extends StatelessWidget {
  final HomeControlerImp controler;
  const MainButtons({super.key, required this.controler});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MainContainer(
              controler: controler,
              icon: Icons.note_add_outlined,
              text: "notes",
              finction: () => controler.gotoNotesPage(context),
            ),
            MainContainer(
                controler: controler,
                icon: Icons.alarm_add_outlined,
                text: "alarm")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MainContainer(
                controler: controler,
                icon: Icons.task_alt_outlined,
                text: "task"),
            MainContainer(
              controler: controler,
              icon: Icons.settings,
              text: "setting",
              finction: () => controler.gotosettinPage(context),
            )
          ],
        )
      ],
    );
  }
}

//!newest Notes section 3

class NewestNotes extends StatelessWidget {
  final HomeControlerImp controler;

  const NewestNotes({super.key, required this.controler});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromRGBO(220, 220, 220, 0.5),
      ),
      width: SizeControler().widthLocal(context),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Text("Newest Notes",
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            Consumer<HomeControlerImp>(builder: (context, value, child) {
              value.getthereIsNewNote() ? null : value.getnewstnote();
              Future.delayed(Duration.zero, () => controler.Startanimated());

              return AnimatedCrossFade(
                firstChild: Center(
                  child: Lottie.asset(
                      frameRate: FrameRate.composition,
                      "lib/assets/image/nodata.json",
                      height: SizeControler().HieghtLocal(context) / 6,
                      fit: BoxFit.contain),
                ),
                secondChild: ListTile(
                  title: Text(value.newestnote?.noteTitle ?? "notitle",
                      style: Theme.of(context).textTheme.bodyText1),
                  subtitle: Text(value.newestnote?.noteBody ?? "nobody",
                      style: Theme.of(context).textTheme.bodyText2),
                ),
                crossFadeState: controler.getthereIsNewNote()
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(seconds: 1),
              );
            })
          ]),
    );
  }
}

//! main container contain main button
// ignore: must_be_immutable
class MainContainer extends StatelessWidget {
  final HomeControlerImp controler;
  final IconData icon;
  final String text;
  void Function()? finction;

  MainContainer(
      {super.key,
      required this.icon,
      required this.text,
      this.finction,
      required this.controler});

  @override
  Widget build(
    BuildContext context,
  ) {
    return InkWell(
      onTap: finction,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1500),
        margin: const EdgeInsets.all(10),
        height: SizeControler().HieghtLocal(context) / 12,
        width: SizeControler().widthLocal(context) / 2.7,
        decoration: BoxDecoration(
          border:
              Border.all(color: Colors.blue, width: controler.animatedborder),
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(220, 220, 220, 0.5),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(text),
              Icon(icon),
            ]),
      ),
    );
  }
}
