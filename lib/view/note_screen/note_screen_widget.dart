import 'package:flutter/material.dart';

import '../../controllers/sizecontroler.dart';

class BackGroundNote extends StatelessWidget {
  const BackGroundNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeControler().HieghtLocal(context) * 1 / 9,
          child: Center(
              child: Text(
            "MY Notes",
            style: TextStyle(
                color: Colors.white,
                fontSize: SizeControler().widthLocal(context) / 12),
          )),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
          child: Stack(children: [
            Image.asset(
                height: SizeControler().HieghtLocal(context) * 8 / 9,
                width: SizeControler().widthLocal(context),
                "lib/assets/image/notesbackground.jpg",
                fit: BoxFit.fill),
            Container(
                height: SizeControler().HieghtLocal(context) * 8 / 9,
                width: SizeControler().widthLocal(context),
                color: const Color.fromRGBO(240, 240, 240, 0.8)),
          ]),
        ),
      ],
    );
  }
}
