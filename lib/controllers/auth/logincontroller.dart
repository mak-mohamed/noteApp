import 'package:flutter/material.dart';
import 'package:noteapp/core/constants/const_route.dart';
import 'package:noteapp/core/fiunctions/getstorange.dart';
import 'package:noteapp/core/statusrequest.dart';
import 'package:noteapp/data/remote/auth/lodin_data.dart';

abstract class LogInControler extends ChangeNotifier {
  login(BuildContext context);
  gotoHome(BuildContext context);
  gotoCreateAccount(BuildContext context);
  changeIssecure();
  initStatus();
  bool itisFailure(StatusRequest statusRequest);
}

class LogInControlerImp extends LogInControler {
  StatusRequest statusRequest = StatusRequest.init;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool issecure = true;

  @override
  changeIssecure() {
    issecure = !issecure;
    notifyListeners();
  }

  @override
  gotoHome(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(ConstRoute.home, (route) => false);
  }

  @override
  gotoCreateAccount(BuildContext context) {
    Navigator.pushNamed(context, ConstRoute.createaccount);
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

  // ignore: annotate_overrides
  login(BuildContext context) async {
    statusRequest = StatusRequest.loading;
    notifyListeners();
    var response =
        await loginData(usernameoremail: email.text, password: password.text);
    response.fold((l) {
      statusRequest = l;
      notifyListeners();
    }, (user) {
      statusRequest = StatusRequest.sucsses;

      MyGetstorange.saveData("user_id", user.userid);
      MyGetstorange.saveData("user_name", user.name);
      MyGetstorange.saveData("user_email", user.email);
      MyGetstorange.saveData("user_password", user.password);
      MyGetstorange.saveData("user_image", user.image);
      notifyListeners();
    });
  }
}
