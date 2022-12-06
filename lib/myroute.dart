import 'package:flutter/material.dart';
import 'package:noteapp/controllers/addorediet_controler.dart';
import 'package:noteapp/controllers/note_controler.dart';
import 'package:noteapp/core/constants/const_route.dart';
import 'package:noteapp/core/fiunctions/getstorange.dart';
import 'package:noteapp/view/addorediet_screen.dart';
import 'package:noteapp/view/auth/createaccount_screen.dart';
import 'package:noteapp/view/auth/login_screen.dart';
import 'package:noteapp/view/home_Screen/homescreen.dart';
import 'package:noteapp/view/note_screen/notes_screen.dart';
import 'package:noteapp/view/onboarding/choiselanguage_screen.dart';
import 'package:noteapp/view/onboarding/onboarding_screen.dart';
import 'package:noteapp/view/setting_Screen.dart';
import 'package:noteapp/view/user_screen/user_screen.dart';
import 'package:provider/provider.dart';
import 'model/user_model.dart';

class MyRoute {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      //! onboarding route
      case ConstRoute.choiselang:
        //?if there is choise alng go to home across choiselang and onboarding
        return MaterialPageRoute(builder: (context) {
          return MyGetstorange.readData("locale") != null
              ? MyGetstorange.readData("user_id") != null
                  ? const HomeScreen()
                  : const LogInScreen()
              : const ChoiseLanguageScreen();
        });
      case ConstRoute.onboarding:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
      //! auth  route
      case ConstRoute.login:
        return MaterialPageRoute(
          builder: (context) {
            return MyGetstorange.readData("user_id") != null
                ? const HomeScreen()
                : const LogInScreen();
          },
        );
      case ConstRoute.createaccount:
        return MaterialPageRoute(
            builder: (context) => const CreateAccountScreen());

      //! home page
      case ConstRoute.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      //! user page
      case ConstRoute.userscreen:
        return MaterialPageRoute(
            builder: (context) => UserScreen(user: settings.arguments as User));

      //! note page
      case ConstRoute.noteScreen:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => NoteControlerImp(),
                child: NoteScreen(user: settings.arguments as User)));

      //! add or ediet
      case ConstRoute.addorediet:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => AddOrEdietControlerImp(),
                  child: AddOrEdietScreen(
                    argument: settings.arguments as Map,
                  ),
                ));

      //! setting
      case ConstRoute.setting:
        return MaterialPageRoute(builder: (context) => const SettingScreen());
    }

    return null;
  }
}
