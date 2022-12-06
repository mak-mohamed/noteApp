import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:noteapp/core/statusrequest.dart';
import 'package:noteapp/data/remote/note/deletenote.dart';
import 'package:noteapp/data/remote/note/edietnote.dart';

import '../data/remote/note/addnote.dart';
import '../model/note_model.dart';

abstract class AddOrEdietControler extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  AddNote(
      {required BuildContext context,
      required String title,
      required String body,
      required int userid});
  gotoNotesPage(BuildContext context);

  edietNote({required BuildContext context, required Note note});
  deleteNote({required BuildContext context, required String noteid});
}

class AddOrEdietControlerImp extends AddOrEdietControler {
  //? constructor and main variable

  String? _addorediet;

  String? get addorediet => _addorediet;

  set addorediet(String? addorediet) {
    _addorediet = addorediet;
    notifyListeners();
  }

  String? title;

  String? body;

  String? userid;

  String? noteid;

//? ksys for forms
  GlobalKey<FormState> globalkey = GlobalKey<FormState>();
  TextEditingController titlekey = TextEditingController();
  TextEditingController bodykey = TextEditingController();

  StatusRequest status = StatusRequest.init;

  @override
  // ignore: non_constant_identifier_names
  AddNote(
      {required BuildContext context,
      required String title,
      required String body,
      required int userid}) async {
    if (globalkey.currentState!.validate()) {
      status = StatusRequest.loading;
      notifyListeners();

      status = await addNoteData(
          note: Note(
        noteBody: bodykey.text,
        noteTitle: titlekey.text,
        noteIdusers: userid,
        noteImage: null,
      ));

      if (status == StatusRequest.sucsses) {
        status = StatusRequest.sucsses;

        notifyListeners();
      } else {
        status = StatusRequest.unExpectedFailuer;

        notifyListeners();
        status = StatusRequest.init;
        notifyListeners();
      }
    }
  }

  @override
  gotoNotesPage(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  edietNote({required BuildContext context, required Note note}) async {
    status = StatusRequest.loading;
    notifyListeners();
    StatusRequest response = await edietNoteData(note);
    if (response == StatusRequest.sucsses) {
      status = StatusRequest.sucsses;

      notifyListeners();
    } else {
      status = StatusRequest.unExpectedFailuer;

      notifyListeners();
    }
  }

  @override
  deleteNote({required BuildContext context, required String noteid}) async {
    status = StatusRequest.loading;
    notifyListeners();

    StatusRequest response = await deleteNoteData(noteid: noteid);
    if (response == StatusRequest.sucsses) {
      status = StatusRequest.sucsses;

      notifyListeners();
    } else {
      status = StatusRequest.unExpectedFailuer;

      notifyListeners();
    }
  }
}
