import 'package:noteapp/core/constants/const_api.dart';
import 'package:noteapp/core/statusrequest.dart';
import 'package:noteapp/data/crud.dart';
import 'package:noteapp/model/note_model.dart';

Future<StatusRequest> edietNoteData(Note note) async {
  Map data = {
    "iduser": note.noteIdusers.toString(),
    "idnote": note.noteId.toString(),
    "title": note.noteTitle,
    "body": note.noteBody,
  };
  return await Crud()
      .postdataStatusrequestonly(url: ConstApi.constupdatenote, data: data);
}
