// ignore_for_file: file_names

import 'dart:io';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:noteapp/controllers/sizecontroler.dart';
import 'package:provider/provider.dart';

class TitleWidget extends StatelessWidget {
  final double hieght;
  final double width;
  final String title;
  final Color maincolor;
  final Color backgroundcolor;
  final String assetpath;
  final bool itiscreateaccount;
  final void Function()? ontap;
  final File? pickimagefile;
  const TitleWidget(
      {super.key,
      this.ontap,
      required this.hieght,
      required this.width,
      required this.title,
      required this.maincolor,
      required this.backgroundcolor,
      required this.assetpath,
      required this.itiscreateaccount,
      this.pickimagefile});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: hieght * 1.2,
        width: width,
        color: backgroundcolor,
      ),
      Positioned(
          top: -width * 1.1,
          left: -width / 4,
          child: Container(
            height: width * 1.5,
            width: width * 1.5,
            decoration: BoxDecoration(
                color: maincolor,
                borderRadius: BorderRadius.circular(width * 1.5)),
          )),
      SizedBox(
        height: hieght / 1.2,
        child: Center(
          child: Text(title, style: Theme.of(context).textTheme.headline1),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: hieght * 0.5),
        child: Center(
          child: itiscreateaccount
              ? Badge(
                  badgeColor: Colors.grey[400]!,
                  elevation: 10,
                  position: BadgePosition.bottomEnd(),
                  badgeContent: const Icon(Icons.add_a_photo_outlined),
                  child: InkWell(
                    onTap: ontap,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(hieght / 2),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(hieght / 2),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: pickimagefile == null
                              ? Image.asset(
                                  assetpath,
                                  height: hieght / 2,
                                  width: hieght / 2,
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  pickimagefile!,
                                  height: hieght / 2,
                                  width: hieght / 2,
                                  fit: BoxFit.fill,
                                )),
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(hieght / 2),
                    border: Border.all(color: Colors.black54),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(hieght / 2),
                    child: Image.asset(
                      assetpath,
                      height: hieght / 2,
                      width: hieght / 2,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
        ),
      ),
    ]);
  }
}

class TextFormfeildCustom extends StatelessWidget {
  final String icon;
  final String hinttext;
  final TextEditingController textcontroller;
  final String? Function(String?)? validator;
  final bool? isobsecure;
  final void Function()? ontap;
  const TextFormfeildCustom(
      {super.key,
      required this.icon,
      required this.hinttext,
      required this.textcontroller,
      required this.validator,
      this.isobsecure,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        obscureText: isobsecure ?? false,
        validator: validator,
        controller: textcontroller,
        maxLines: 1,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            prefixIcon: InkWell(
                onTap: ontap,
                child: SizedBox(
                    height:
                        context.read<SizeControler>().HieghtLocal(context) / 35,
                    width:
                        context.read<SizeControler>().widthLocal(context) / 35,
                    child: Lottie.asset(icon))),
            hintText: hinttext,
            hintStyle: Theme.of(context).textTheme.bodySmall),
      ),
    );
  }
}
