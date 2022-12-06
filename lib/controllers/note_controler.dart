import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/core/constants/const_route.dart';
import 'package:noteapp/core/statusrequest.dart';
import 'package:noteapp/data/remote/note/getnotes_data.dart';
import 'package:noteapp/model/note_model.dart';

abstract class NoteControler extends ChangeNotifier {
  getAllNotes({required String userid});

  bool itisloading();
  bool itissucsess();
  bool itissucsessbutnodata();
  bool itisfailuer();
  gotoAddNote(BuildContext context);
  gotoEdietNote(BuildContext context, Note note);
}

class NoteControlerImp extends NoteControler {
  StatusRequest statusrequest = StatusRequest.init;
  List<Note> notes = [];

  @override
  getAllNotes({required String userid}) async {
    statusrequest = StatusRequest.loading;
    notes = [];
    notifyListeners();
    Either<StatusRequest, List> failorlistnote =
        await getAllNotesData(userid: userid);
    failorlistnote.fold((status) {
      statusrequest = status;
      notifyListeners();
    }, (listnotes) {
      for (var element in listnotes) {
        notes.add(Note(
            noteId: int.parse(element["note_id"]),
            noteBody: element["note_body"],
            noteIdusers: int.parse(element["note_idusers"]),
            noteTitle: element["note_title"],
            noteImage: element["note_image"]));
      }

      // ignore: prefer_is_empty
      if (notes.length != 0) {
        statusrequest = StatusRequest.sucsses;
      } else {
        statusrequest = StatusRequest.sucsess_but_no_data;
      }
    });
    notifyListeners();
  }

  @override
  bool itisloading() {
    if (statusrequest == StatusRequest.loading) {
      return true;
    } else {
      return false;
    }
  }

  @override
  bool itisfailuer() {
    if (statusrequest == StatusRequest.offlineFailuer ||
        statusrequest == StatusRequest.serverFailuer ||
        statusrequest == StatusRequest.unExpectedFailuer) {
      return true;
    } else {
      return false;
    }
  }

  @override
  bool itissucsess() {
    if (statusrequest == StatusRequest.sucsses) {
      return true;
    } else {
      return false;
    }
  }

  @override
  bool itissucsessbutnodata() {
    if (statusrequest == StatusRequest.sucsess_but_no_data) {
      return true;
    } else {
      return false;
    }
  }

  @override
  gotoAddNote(BuildContext context) {
    Navigator.pushNamed(context, ConstRoute.addorediet,
        arguments: {"addorediet": "true", "title": "", "body": ""});
  }

  @override
  gotoEdietNote(BuildContext context, Note note) {
    Navigator.pushNamed(context, ConstRoute.addorediet, arguments: {
      "addorediet": "false",
      "title": note.noteTitle,
      "body": note.noteBody,
      "userid": note.noteIdusers.toString(),
      "noteid": note.noteId.toString()
    });
  }
}
