// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:noteapp/controllers/locale_controller.dart';
import 'package:noteapp/controllers/sizecontroler.dart';
import 'package:noteapp/controllers/themecontoler.dart';
import 'package:noteapp/core/fiunctions/getstorange.dart';
import 'package:noteapp/core/mytheme.dart';
import 'package:noteapp/view/auth/authWidget.dart';
import 'package:noteapp/view/basic%20widget/customsizebox.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //! title and pic
          TitleWidget(
              hieght: SizeControler().HieghtLocal(context) / 4,
              width: SizeControler().widthLocal(context),
              title: "Setting",
              maincolor: Theme.of(context).primaryColor,
              backgroundcolor: Theme.of(context).backgroundColor,
              assetpath: "lib/assets/image/sing.jpg",
              itiscreateaccount: false),
          Expanded(
            child: Container(
                color: Theme.of(context).backgroundColor,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    //! localization radio button
                    ExpansionTile(
                      title: Text("Localization",
                          style: Theme.of(context).textTheme.bodyText1),
                      childrenPadding: const EdgeInsets.all(5),
                      children: [
                        RadioListTile(
                          title: Text("English",
                              style: Theme.of(context).textTheme.bodyLarge),
                          value: "en",
                          groupValue:
                              context.watch<MyLocaleControler>().localcode,
                          onChanged: (value) {
                            Provider.of<MyLocaleControler>(context,
                                    listen: false)
                                .changeLocal(value!);
                          },
                        ),
                        RadioListTile(
                          title: Text("arabic",
                              style: Theme.of(context).textTheme.bodyLarge),
                          value: "ar",
                          groupValue:
                              context.watch<MyLocaleControler>().localcode,
                          onChanged: (value) {
                            Provider.of<MyLocaleControler>(context,
                                    listen: false)
                                .changeLocal(value!);
                          },
                        )
                      ],
                    ),
                    CustomSizeBox(type: 1),
                    //! theme radio button
                    ExpansionTile(
                      title: Text("Theme",
                          style: Theme.of(context).textTheme.bodyText1),
                      childrenPadding: const EdgeInsets.all(5),
                      children: [
                        RadioListTile(
                            title: Text("Light",
                                style: Theme.of(context).textTheme.bodyText1),
                            value: MyGetstorange.readData("locale") == "en"
                                ? MyTheme.lightthemeenglish
                                : MyTheme.lightthemearabic,
                            groupValue: context.read<ThemeControler>().theme,
                            onChanged: (value) {
                              Provider.of<ThemeControler>(context,
                                      listen: false)
                                  .changeTheme(
                                light: true,
                                english:
                                    MyGetstorange.readData("locale") == "en"
                                        ? true
                                        : false,
                              );
                            }),
                        RadioListTile(
                            title: Text("dark",
                                style: Theme.of(context).textTheme.bodyText1),
                            value: MyGetstorange.readData("locale") == "en"
                                ? MyTheme.darkthemeenglish
                                : MyTheme.darkthemearabic,
                            groupValue: context.read<ThemeControler>().theme,
                            onChanged: (value) => Provider.of<ThemeControler>(
                                        context,
                                        listen: false)
                                    .changeTheme(
                                  light: false,
                                  english:
                                      MyGetstorange.readData("locale") == "en"
                                          ? true
                                          : false,
                                ))
                      ],
                    ),
                    CustomSizeBox(type: 6),
                    //! sing out button
                    InkWell(
                        child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      child: Center(
                        child: Text("Singout",
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                    ))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
