import 'package:flutter/cupertino.dart';
import 'package:noteapp/core/constants/const_route.dart';

import '../core/fiunctions/getstorange.dart';

class MyLocaleControler extends ChangeNotifier {
  String localcode = MyGetstorange.readData("locale") ?? "en";
  Locale mylocoale = Locale(MyGetstorange.readData("locale") ?? "en");

  saveLocalCode(String val) {
    MyGetstorange.saveData("locale", val);
  }

  String readLocalSaved() {
    return MyGetstorange.readData("locale") ?? "en";
  }

  bool thereisSavedLocale() {
    return MyGetstorange.readData("locale") != null ? true : false;
  }

  gotToOnBoarding(BuildContext context) {
    saveLocalCode(localcode);
    Navigator.pushNamed(context, ConstRoute.onboarding);
  }

  changeLocal(String val) {
    localcode = val;
    mylocoale = Locale(val);
    notifyListeners();
  }
}
