import 'package:dartz/dartz.dart';
import 'package:noteapp/core/constants/const_api.dart';
import 'package:noteapp/core/statusrequest.dart';
import 'package:noteapp/data/crud.dart';

Future<Either<StatusRequest, List>> getAllNotesData(
    {required String userid}) async {
  return await Crud()
      .postdatadynamic(url: ConstApi.constviewnotes, data: {"iduser": userid});
}
