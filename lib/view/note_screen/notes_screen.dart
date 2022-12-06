import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:noteapp/controllers/note_controler.dart';
import 'package:noteapp/core/statusrequest.dart';
import 'package:noteapp/view/basic%20widget/loading_widget.dart';
import 'package:provider/provider.dart';
import '../../controllers/sizecontroler.dart';
import '../../core/fiunctions/showtost.dart';
import '../../model/note_model.dart';
import '../../model/user_model.dart';
import 'note_screen_widget.dart';

class NoteScreen extends StatelessWidget {
  final User user;

  const NoteScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    //? call method like init
    Future.delayed(
        Duration.zero,
        () =>
            context.read<NoteControlerImp>().getAllNotes(userid: user.userid!));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 31, 60, 129),
      body: Stack(children: [
        const BackGroundNote(),
        NoteStateHandling(
          user: user,
        )
      ]),
      floatingActionButton: const FlatButtonWidget(),
    );
  }
}

class NoteStateHandling extends StatelessWidget {
  final User user;

  const NoteStateHandling({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteControlerImp>(builder: (context, controler, child) {
      if (controler.itisloading()) {
        return const LoadingWidgte();
      } else if (controler.itissucsessbutnodata()) {
        return SucsessButNoDataState(
          controler: controler,
          user: user,
        );
      } else if (controler.itisfailuer()) {
        return FailuerState(
          user: user,
          controler: controler,
        );
      } else if (controler.itissucsess()) {
        return SucsessState(
          controler: controler,
          user: user,
        );
      } else
        // ignore: curly_braces_in_flow_control_structures
        return const Text(
          "not be  there",
          style: TextStyle(color: Colors.red, fontSize: 20),
        );
    });
  }
}

class SucsessState extends StatelessWidget {
  final NoteControlerImp controler;
  final User user;
  const SucsessState({super.key, required this.controler, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeControler().HieghtLocal(context) * 1 / 9),
        SizedBox(
          height: SizeControler().HieghtLocal(context) * 8 / 9,
          child: RefreshIndicator(
            color: const Color.fromARGB(255, 23, 60, 93),
            onRefresh: () => controler.getAllNotes(userid: user.userid!),
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controler.notes.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: NoteCard(
                  controler: controler,
                  note: controler.notes[index],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SucsessButNoDataState extends StatelessWidget {
  final NoteControlerImp controler;
  final User user;
  const SucsessButNoDataState(
      {super.key, required this.controler, required this.user});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controler.getAllNotes(userid: user.userid!),
      child: Center(
        child: Lottie.asset(
            frameRate: FrameRate.composition,
            "lib/assets/image/nodata.json",
            height: SizeControler().HieghtLocal(context) / 6,
            fit: BoxFit.contain),
      ),
    );
  }
}

class FailuerState extends StatelessWidget {
  final NoteControlerImp controler;
  final User user;

  const FailuerState({super.key, required this.controler, required this.user});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      ShowToastCustom(
        context,
        toasttype: Toasttype.error,
        title: "warning",
        body: "we well try again",
      );
      Timer(const Duration(seconds: 5),
          () => controler.statusrequest = StatusRequest.init);
    });
    return Center(
        child: InkWell(
            onTap: () => controler.getAllNotes(userid: user.userid!),
            child: Icon(
                color: const Color.fromARGB(255, 22, 82, 132),
                size: SizeControler().widthLocal(context) / 6,
                Icons.replay_circle_filled_sharp)));
  }
}

class FlatButtonWidget extends StatelessWidget {
  const FlatButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controler = Provider.of<NoteControlerImp>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
          onTap: () => controler.gotoAddNote(context),
          child: Container(
            height: SizeControler().HieghtLocal(context) / 15,
            width: SizeControler().widthLocal(context) / 8,
            color: Colors.grey[600],
            child: const Icon(Icons.add_circle_outline, size: 35),
          )),
    );
  }
}

class NoteCard extends StatelessWidget {
  final NoteControlerImp controler;
  final Note note;
  const NoteCard({super.key, required this.controler, required this.note});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controler.gotoEdietNote(context, note),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        padding: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromRGBO(180, 180, 180, 0.95),
        ),
        width: SizeControler().widthLocal(context),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(note.noteTitle ?? "No title"),
                subtitle: Text(note.noteBody ?? "No Body"),
              )
            ]),
      ),
    );
  }
}
