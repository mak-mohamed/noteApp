import 'package:flutter/material.dart';
import 'package:noteapp/controllers/addorediet_controler.dart';
import 'package:noteapp/core/fiunctions/getstorange.dart';
import 'package:noteapp/core/fiunctions/showtost.dart';
import 'package:noteapp/core/statusrequest.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/view/basic%20widget/customsizebox.dart';
import 'package:noteapp/view/basic%20widget/loading_widget.dart';
import 'package:provider/provider.dart';
import '../controllers/sizecontroler.dart';
import '../core/fiunctions/myvalidator.dart';
import 'note_screen/note_screen_widget.dart';

class AddOrEdietScreen extends StatelessWidget {
  final Map argument;
  const AddOrEdietScreen({
    super.key,
    required this.argument,
  });

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {
        context.read<AddOrEdietControlerImp>().titlekey.text =
            argument["title"].toString();

        context.read<AddOrEdietControlerImp>().bodykey.text =
            argument["body"].toString();
        context.read<AddOrEdietControlerImp>().addorediet =
            argument["addorediet"];
        context.read<AddOrEdietControlerImp>().userid = argument["userid"];
        context.read<AddOrEdietControlerImp>().noteid = argument["noteid"];
      },
    );
    //
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 31, 60, 129),
      body: Stack(children: [
        const BackGroundNote(),
        Consumer<AddOrEdietControlerImp>(
          builder: (context, controler, child) {
            Future.delayed(
              Duration.zero,
              () {
                if (controler.status == StatusRequest.sucsses) {
                  controler.gotoNotesPage(context);
                } else if (controler.status ==
                    StatusRequest.unExpectedFailuer) {
                  ShowToastCustom(context,
                      toasttype: Toasttype.error,
                      title: "falied",
                      body: "try again later ");
                }
              },
            );
            return HandlingStatus(controler: controler);
          },
        )
      ]),
    );
  }
}

class HandlingStatus extends StatelessWidget {
  final AddOrEdietControlerImp controler;
  const HandlingStatus({super.key, required this.controler});

  @override
  Widget build(BuildContext context) {
    return controler.status == StatusRequest.loading
        ? const LoadingWidgte()
        : AddOrEdietScreenBody(
            controler: controler,
          );
  }
}

class AddOrEdietScreenBody extends StatelessWidget {
  final AddOrEdietControlerImp controler;
  const AddOrEdietScreenBody({super.key, required this.controler});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {
        if (controler.status == StatusRequest.sucsses) {
          ShowToastCustom(context,
              toasttype: Toasttype.sucsess,
              title: "Sucsess",
              body: "done Sucsessfly");
        } else if (controler.status == StatusRequest.unExpectedFailuer) {
          ShowToastCustom(context,
              toasttype: Toasttype.error,
              title: "Error",
              body: "Some thing worng please try again");
        }
      },
    );
    return Form(
      key: controler.globalkey,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomSizeBox(type: 6),
                //? title text
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    validator: (value) =>
                        myValidator(context, value, 1, 50, "title"),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      label: const Text("     Title"),
                      border: OutlineInputBorder(
                          gapPadding: 5,
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 141, 168, 20))),
                    ),
                    controller: controler.titlekey,
                    maxLines: 3,
                    minLines: 1,
                  ),
                ),
                CustomSizeBox(type: 4),
                //? body text
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    validator: (value) =>
                        myValidator(context, value, 1, 500, "title"),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      label: const Text("     body"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 4, 16, 26))),
                    ),
                    controller: controler.bodykey,
                    minLines: 3,
                    maxLines: 10,
                  ),
                ),
                CustomSizeBox(type: 6),
                //?  button
                controler.addorediet == "true"
                    ? ButtonForAdd(
                        controler: controler,
                      )
                    : ButtonForEdietAndDelete(
                        controler: controler,
                      ),
              ],
            ),
          )),
    );
  }
}

//? button for add
class ButtonForAdd extends StatelessWidget {
  final AddOrEdietControlerImp controler;
  const ButtonForAdd({super.key, required this.controler});

  @override
  Widget build(BuildContext context) {
    return CustomButtom(
        buttonName: "Add",
        function: () => controler.AddNote(
              context: context,
              title: controler.titlekey.text,
              body: controler.bodykey.text,
              userid: int.parse(MyGetstorange.readData("user_id")!),
            ));
  }
}

//? button for ediet and delete
class ButtonForEdietAndDelete extends StatelessWidget {
  final AddOrEdietControlerImp controler;

  const ButtonForEdietAndDelete({super.key, required this.controler});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomButtom(
          buttonName: "ediet",
          function: () => controler.edietNote(
              context: context,
              note: Note(
                  noteIdusers: int.parse(controler.userid!),
                  noteTitle: controler.titlekey.text,
                  noteBody: controler.bodykey.text,
                  noteId: int.parse(controler.noteid!))),
        ),
        CustomButtom(
          buttonName: "delete",
          function: () =>
              controler.deleteNote(context: context, noteid: controler.noteid!),
        )
      ],
    );
  }
}

//? custom button
class CustomButtom extends StatelessWidget {
  final void Function()? function;
  final String buttonName;
  const CustomButtom({
    super.key,
    this.function,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[400],
            border: Border.all(),
            borderRadius: BorderRadius.circular(20)),
        height: SizeControler().HieghtLocal(context) / 14,
        width: SizeControler().widthLocal(context) / 4,
        child: InkWell(
          onTap: function,
          child: Center(child: Text(buttonName)),
        ));
  }
}
