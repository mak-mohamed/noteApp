import 'package:flutter/cupertino.dart';

class SizeControler extends ChangeNotifier {
  double widthLocal(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // ignore: non_constant_identifier_names
  double HieghtLocal(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
