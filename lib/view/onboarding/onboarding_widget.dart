import 'package:flutter/material.dart';
import 'package:noteapp/controllers/sizecontroler.dart';

class OnboardingWidget extends StatelessWidget {
  final Color color;
  final String image;
  final String title;
  final String body;
  final Widget? widget;

  const OnboardingWidget(
      {super.key,
      required this.color,
      required this.image,
      required this.title,
      required this.body,
      this.widget});
  @override
  Widget build(BuildContext context) {
    final sizecontroler = SizeControler();
    return Scaffold(
        backgroundColor: color,
        body: SizedBox(
          height: sizecontroler.HieghtLocal(context) / 1.1,
          child: ListView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              //!image
              SizedBox(height: sizecontroler.HieghtLocal(context) / 15),
              Image.asset(image,
                  height: SizeControler().HieghtLocal(context) / 5,
                  width: SizeControler().HieghtLocal(context) / 5,
                  cacheHeight: SizeControler().HieghtLocal(context) ~/ 4,
                  cacheWidth: SizeControler().widthLocal(context) * 4 ~/ 5,
                  fit: BoxFit.contain),
              SizedBox(height: sizecontroler.HieghtLocal(context) / 10),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(title,
                      style: Theme.of(context).textTheme.headline1)),
              SizedBox(height: sizecontroler.HieghtLocal(context) / 15),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  body,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Center(child: widget)
            ],
          ),
        ));
  }
}
