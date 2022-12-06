// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/sizecontroler.dart';

// ignore: must_be_immutable
class CustomSizeBox extends StatelessWidget {
  int type;
  CustomSizeBox({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        if (type == 0) {
      return SizedBox(
        height: context.read<SizeControler>().HieghtLocal(context) / 70,
      );
    }
    
    if (type == 1) {
      return SizedBox(
        height: context.read<SizeControler>().HieghtLocal(context) / 50,
      );
    }
    if (type == 2) {
      return SizedBox(
        height: context.read<SizeControler>().HieghtLocal(context) / 40,
      );
    }
    if (type == 3) {
      return SizedBox(
        height: context.read<SizeControler>().HieghtLocal(context) / 30,
      );
    }
    if (type == 4) {
      return SizedBox(
        height: context.read<SizeControler>().HieghtLocal(context) / 20,
      );
    }
    if (type == 5) {
      return SizedBox(
        height: context.read<SizeControler>().HieghtLocal(context) / 10,
      );
    }
    if (type == 6) {
      return SizedBox(
        height: context.read<SizeControler>().HieghtLocal(context) / 7,
      );
    }
    if (type == 7) {
      return SizedBox(
        height: context.read<SizeControler>().HieghtLocal(context) / 5,
      );
    }
    if (type == 8) {
      return SizedBox(
        height: context.read<SizeControler>().HieghtLocal(context) / 4,
      );
    }
    if (type == 9) {
      return SizedBox(
        height: context.read<SizeControler>().HieghtLocal(context) / 3,
      );
    }
    if (type == 10) {
      return SizedBox(
        height: context.read<SizeControler>().HieghtLocal(context) / 2,
      );
    }
    return SizedBox(
      height: context.read<SizeControler>().HieghtLocal(context) / 50,
    );
  }
}
