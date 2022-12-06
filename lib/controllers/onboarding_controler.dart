import 'package:flutter/material.dart';
import 'package:noteapp/core/constants/const_route.dart';

import '../view/onboarding/onboarding_screen.dart';

abstract class OnboardingControler extends ChangeNotifier {
  Color dotsColor(int index);
  void changeActivePage(int page);
  Widget islastOnBoardingShowButton(
      int index, OnboardingcontrolerImp controler);
  void gotoSingup(BuildContext context);
}

class OnboardingcontrolerImp extends OnboardingControler {
  final PageController pageController = PageController(initialPage: 0);
  int activePage = 0;

  final List<Widget> pages = [
    const PageOne(),
    const PageTwo(),
    const PageThree()
  ];

  @override
  Color dotsColor(int index) {
    return activePage == index ? Colors.amber : Colors.grey;
  }

  @override
  void changeActivePage(int page) {
    activePage = page;
    notifyListeners();
  }

  @override
  Widget islastOnBoardingShowButton(
      int index, OnboardingcontrolerImp controler) {
    if (index != 2) {
      return Indicators(controler: controler);
    } else {
      return letsGoButton(
        controler: controler,
      );
    }
  }

  @override
  void gotoSingup(BuildContext context) {
    Navigator.pushReplacementNamed(context, ConstRoute.login);
  }
}
