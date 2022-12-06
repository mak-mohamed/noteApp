// ignore_for_file: file_names

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:noteapp/core/constants/const_api.dart';
import 'package:noteapp/data/crud.dart';
import 'package:noteapp/model/user_model.dart';
import '../../../core/statusrequest.dart';

Future<Either<StatusRequest, bool>> singup(User user, File file) async {
  return await Crud().postdataWithfile(
      url: ConstApi.constcreateaccount,
      data: {"name": user.name, "email": user.email, "password": user.password},
      file: file);
}
