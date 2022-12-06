import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:noteapp/controllers/locale_controller.dart';
import 'package:noteapp/controllers/themecontoler.dart';
import 'package:provider/provider.dart';
import 'controllers/sizecontroler.dart';

import 'core/locale/mylocale.dart';
import 'myroute.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeControler()),
          ChangeNotifierProvider(create: (context) => SizeControler()),
          ChangeNotifierProvider(
            create: (context) => MyLocaleControler(),
          )
        ],
        builder: (context, child) =>
            Consumer<ThemeControler>(builder: (context, themecontroler, child) {
              themecontroler.getThemeSaved();

              return Consumer<MyLocaleControler>(
                  builder: (context, value, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: MyRoute().onGenerateRoute,
                  title: 'noteapp',
                  supportedLocales: const [Locale('en'), Locale('ar')],
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  locale: context.watch<MyLocaleControler>().mylocoale,
                  theme: themecontroler.theme,
                );
              });
            }));
  }
}
