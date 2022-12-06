import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/core/constants/const_route.dart';
import 'package:noteapp/core/statusrequest.dart';
import '../../data/remote/auth/createaccount-data.dart';
import '../../model/user_model.dart';

abstract class CreateAccountControler extends ChangeNotifier {
  bool itisFailure(StatusRequest statusRequest);
  createaccount(BuildContext context);
  changeIssecure();
  gotoSingUp(BuildContext context);
  initStatus();
  pickimage(BuildContext contex);
}

class CreateAccountControlerImp extends CreateAccountControler {
  StatusRequest statusRequest = StatusRequest.init;
//!=================================================

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
  //!=================================================
  bool issecure = true;
  File? image;

  @override
  changeIssecure() {
    issecure = !issecure;
    notifyListeners();
  }

  @override
  gotoSingUp(BuildContext context) {
    Navigator.of(context).popAndPushNamed(ConstRoute.login);
  }

  @override
  createaccount(BuildContext context) async {
    if (globalKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      notifyListeners();

      User user = User(
          userid: null,
          name: username.text,
          email: email.text,
          password: password.text,
          image: image?.path);
      var requset = await singup(user, image!);
      requset.fold((failuer) {
        statusRequest = failuer;
        debugPrint('we are in controller in failuer');
        notifyListeners();
      }, (sucsess) {
        statusRequest = StatusRequest.sucsses;
        debugPrint('we are in controller in sucsess');
        notifyListeners();
      });
    }
  }

  @override
  bool itisFailure(StatusRequest statusRequest) {
    if (statusRequest == StatusRequest.offlineFailuer ||
        statusRequest == StatusRequest.unExpectedFailuer ||
        statusRequest == StatusRequest.serverFailuer ||
        statusRequest == StatusRequest.sucsess_but_no_data) {
      return true;
    }
    return false;
  }

  @override
  initStatus() {
    statusRequest = StatusRequest.init;
    notifyListeners();
  }

  @override
  pickimage(BuildContext contex) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        context: contex,
        builder: (context) => Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  border: Border.all()),
              height: 100,
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          image = File((await ImagePicker()
                                  .pickImage(source: ImageSource.camera))!
                              .path);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          notifyListeners();
                        },
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(25),
                            child: Text('camera'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            image = File((await ImagePicker()
                                    .pickImage(source: ImageSource.gallery))!
                                .path);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();

                            notifyListeners();
                          },
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(25),
                              child: Text('galery'),
                            ),
                          ),
                        ))
                  ]),
            ));
  }
}
