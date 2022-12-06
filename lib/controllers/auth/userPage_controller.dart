// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:noteapp/controllers/sizecontroler.dart';

class UserControlerImp extends ChangeNotifier {
  double animatedcontainerhieght = 0;
  double animatedimagehieght = 0;

  getanimatedhieght() => animatedcontainerhieght;

  startanimated(BuildContext context) {
    if (animatedcontainerhieght == 0) {
      animatedcontainerhieght = SizeControler().HieghtLocal(context) / 8;
      animatedimagehieght = SizeControler().HieghtLocal(context) / 5;
    }
    notifyListeners();
  }
}
