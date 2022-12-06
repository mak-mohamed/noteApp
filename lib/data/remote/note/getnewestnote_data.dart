import 'package:dartz/dartz.dart';
import 'package:noteapp/core/constants/const_api.dart';
import 'package:noteapp/core/statusrequest.dart';
import 'package:noteapp/data/crud.dart';
import 'package:noteapp/model/note_model.dart';

Future<Either<StatusRequest, Note>> getNewNoteData(int userid) async {
  return await Crud().postdataNewNotes(
      url: ConstApi.constNewNote, data: {"iduser": userid.toString()});
}
