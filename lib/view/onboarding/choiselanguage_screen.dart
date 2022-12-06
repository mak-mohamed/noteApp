import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:noteapp/core/locale/mylocale.dart';
import 'package:provider/provider.dart';
import '../../controllers/locale_controller.dart';
import '../../controllers/sizecontroler.dart';

class ChoiseLanguageScreen extends StatelessWidget {
  const ChoiseLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizecontroler = SizeControler();
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: sizecontroler.HieghtLocal(context) / 15),
        Lottie.asset("lib/assets/image/choiselanguage.json",
            height: 200, width: 200, fit: BoxFit.fill),
        SizedBox(height: sizecontroler.HieghtLocal(context) / 15),
        RadioListTile(
          groupValue: context.watch<MyLocaleControler>().localcode,
          value: "en",
          onChanged: (value) {
            Provider.of<MyLocaleControler>(context, listen: false)
                .changeLocal(value!);
          },
          title: Text('english'.tr(context),
              style: Theme.of(context).textTheme.bodyText1),
        ),
        RadioListTile(
          value: "ar",
          groupValue: context.watch<MyLocaleControler>().localcode,
          onChanged: (value) {
            Provider.of<MyLocaleControler>(context, listen: false)
                .changeLocal(value!);
          },
          title: Text(
            'arabic'.tr(context),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        const Spacer(),
        Padding(
          padding:
              EdgeInsets.only(bottom: sizecontroler.HieghtLocal(context) / 10),
          child: TextButton(
              onPressed: () {
                Provider.of<MyLocaleControler>(context, listen: false)
                    .gotToOnBoarding(context);
              },
              child: Text(
                'ok'.tr(context),
                style: Theme.of(context).textTheme.bodyText1,
              )),
        )
      ],
    )));
  }
}
