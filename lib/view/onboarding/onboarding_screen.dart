// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:noteapp/controllers/onboarding_controler.dart';
import 'package:noteapp/core/constants/const_color.dart';
import 'package:noteapp/core/locale/mylocale.dart';
import 'package:noteapp/view/onboarding/onboarding_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => OnboardingcontrolerImp(),
        child: Consumer<OnboardingcontrolerImp>(
          builder: (context, controler, child) {
            return Stack(children: [
              PageView.builder(
                itemCount: controler.pages.length,
                itemBuilder: (context, index) {
                  return controler.pages[index % controler.pages.length];
                },
                controller: controler.pageController,
                onPageChanged: (int page) {
                  controler.changeActivePage(page);
                },
              ),

              // Display the dots indicator
              //? dots widget ////////////
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 100,
                child: Center(
                    child: controler.islastOnBoardingShowButton(
                        controler.activePage, controler)),
              )
            ]);
          },
        ),
      ),
    );
  }
}

// Page One
class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OnboardingWidget(
      color: ConstColor.onboarding1,
      image: "lib/assets/image/onboarding1.JPG",
      title: "Remember your activities".tr(context),
      body:
          "Do not worry about remembering your daily activities that interest you and may forget them during the busy day"
              .tr(context),
    );
  }
}

// Page Two
class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnboardingWidget(
      color: ConstColor.onboarding2,
      image: "lib/assets/image/onboarding2.JPG",
      title: "Time Management".tr(context),
      body: "Organizing time and giving statistics on how you invest your time"
          .tr(context),
    );
  }
}

// Page Three
class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: OnboardingWidget(
        color: ConstColor.onboarding3,
        image: "lib/assets/image/onboarding 3.jpg",
        title: "Personalize interests".tr(context),
        body:
            "Personalize interests from work, home, entertainment, and any other aspects of your life"
                .tr(context),
      ),
    );
  }
}

// ignore: must_be_immutable
class Indicators extends StatelessWidget {
  OnboardingcontrolerImp controler;
  Indicators({Key? key, required this.controler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: controler.pages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 5,
            backgroundColor:
                controler.activePage == index ? Colors.amber : Colors.grey,
          ),
        );
      },
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class letsGoButton extends StatelessWidget {
  OnboardingcontrolerImp controler;
  letsGoButton({
    Key? key,
    required this.controler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        controler.gotoSingup(context);
      },
      child: Text("lets start".tr(context),
          style: Theme.of(context).textTheme.bodyText1),
    );
  }
}
