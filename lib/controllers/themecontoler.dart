import 'package:flutter/material.dart';
import 'package:noteapp/controllers/locale_controller.dart';
import 'package:noteapp/core/fiunctions/getstorange.dart';
import 'package:noteapp/core/mytheme.dart';

class ThemeControler extends ChangeNotifier {
  MyLocaleControler localcontroler = MyLocaleControler();

  ThemeData theme = MyTheme.lightthemeenglish;

  changeTheme({required bool light, required bool english}) {
    if (light == true && english == true) {
      theme = MyTheme.lightthemeenglish;
      themeSave(light: light, english: english);
    } else if (light == true && english == false) {
      theme = MyTheme.lightthemearabic;
      themeSave(light: light, english: english);
    } else if (light == false && english == true) {
      theme = MyTheme.darkthemeenglish;
      themeSave(light: light, english: english);
    } else if (light == false && english == false) {
      theme = MyTheme.darkthemearabic;
      themeSave(light: light, english: english);
    }

    notifyListeners();
  }

  themeSave({required bool light, required bool english}) {
    if (light == true && english == true) {
      MyGetstorange.saveData("theme", "lightenglish");
    } else if (light == true && english == false) {
      MyGetstorange.saveData("theme", "lightarabic");
    } else if (light == false && english == true) {
      MyGetstorange.saveData("theme", "darkenglish");
    } else if (light == false && english == false) {
      MyGetstorange.saveData("theme", "darkarabic");
    }
  }

  getThemeSaved() {
    String? stronagetheme = MyGetstorange.readData("theme");
    if (stronagetheme == "lightenglish") {
      theme = MyTheme.lightthemeenglish;
    } else if (stronagetheme == "lightarabic") {
      theme = MyTheme.lightthemearabic;
    } else if (stronagetheme == "darkenglish") {
      theme = MyTheme.darkthemeenglish;
    } else if (stronagetheme == "darkarabic") {
      theme = MyTheme.darkthemearabic;
    }
  }
}
