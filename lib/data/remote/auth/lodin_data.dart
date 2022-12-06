import 'package:dartz/dartz.dart';
import 'package:noteapp/core/constants/const_api.dart';
import 'package:noteapp/data/crud.dart';
import 'package:noteapp/model/user_model.dart';

import '../../../core/statusrequest.dart';

Future<Either<StatusRequest, User>> loginData(
    {required String usernameoremail, required String password}) async {
  return await Crud().postForLogin(
      url: ConstApi.constlogin,
      data: {"email": usernameoremail, "password": password});
}
