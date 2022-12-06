import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noteapp/core/constants/const_route.dart';
import 'package:noteapp/core/statusrequest.dart';
import 'package:noteapp/model/note_model.dart';

import '../data/remote/note/getnewestnote_data.dart';
import '../model/user_model.dart';

abstract class HomeControler extends ChangeNotifier {
  bool thereisimage();

  gotoNotesPage(BuildContext context);

  gotosettinPage(BuildContext context);
  gotoUserPage(BuildContext context);
  getnewstnote();
  // ignore: non_constant_identifier_names
  Startanimated();
}

class HomeControlerImp extends HomeControler {
  HomeControlerImp({required this.user});
  final User user;
  Note? newestnote;
  bool callFunTogetnewnote = false;
  double animatedborder = 0;
  bool animateddone = false;

  StatusRequest statusRequestNewestNotes = StatusRequest.sucsess_but_no_data;

  bool getthereIsNewNote() => callFunTogetnewnote;

  @override
  bool thereisimage() {
    if (user.image == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  gotoNotesPage(BuildContext context) {
    Navigator.pushNamed(context, ConstRoute.noteScreen, arguments: user);
  }

  @override
  gotoUserPage(BuildContext context) {
    Navigator.of(context).pushNamed(ConstRoute.userscreen, arguments: user);
  }

  @override
  gotosettinPage(BuildContext context) {
    Navigator.pushNamed(context, ConstRoute.setting);
  }

  @override
  getnewstnote() async {
    var noteOrFailuer = await getNewNoteData(int.parse(user.userid!));
    noteOrFailuer.fold((failuer) {}, (note) {
      if (note.noteTitle != null || note.noteTitle != "") {
        newestnote = note;
        callFunTogetnewnote = true;
      } else {}
      callFunTogetnewnote != true ? callFunTogetnewnote = true : null;
      notifyListeners();
    });
  }

  @override
  // ignore: non_constant_identifier_names
  Startanimated() {
    if (animateddone == false) {
      animatedborder = 5;
      notifyListeners();
      Timer(
        const Duration(milliseconds: 1000),
        () {
          animatedborder = 0;
          animateddone = true;
          notifyListeners();
        },
      );
    }
  }
}
