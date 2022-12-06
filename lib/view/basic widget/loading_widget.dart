import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/sizecontroler.dart';

class LoadingWidgte extends StatelessWidget {
  const LoadingWidgte({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(
            height: SizeControler().HieghtLocal(context) / 5,
            width: SizeControler().widthLocal(context) / 2,
            "lib/assets/image/waitingblue.json"));
  }
}
