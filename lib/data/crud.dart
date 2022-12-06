// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp/core/fiunctions/checkinternet.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/model/user_model.dart';
import '../core/statusrequest.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

String _authBasic = 'Basic ${base64Encode(utf8.encode('mak:mak1993'))}';
Map<String, String> myheader = {"authorization": _authBasic};

class Crud {
  Future<Either<StatusRequest, List>> getdata(String url) async {
    try {
      if (await InternetConnectionChecker().hasConnection) {
        var response = await http.get(Uri.parse(url), headers: myheader);
        debugPrint('${response.statusCode}  --------------  ');
        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('sucsess connection');
          // ignore: unnecessary_null_comparison
          if (response.body == null) {
            return const Left(StatusRequest.sucsess_but_no_data);
          } else {
            List l = jsonDecode(response.body);
            // print(l.length);
            return Right(l);
          }
        } else {
          debugPrint('server failuer');
          return const Left(StatusRequest.serverFailuer);
        }
      } else {
        debugPrint('off line');
        return const Left(StatusRequest.offlineFailuer);
      }
    } catch (e) {
      debugPrint(e.toString());
      return const Left(StatusRequest.unExpectedFailuer);
    }
  }

  Future<Either<StatusRequest, bool>> postdata(
      {required String url, required data}) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(Uri.parse(url), body: data);
        debugPrint('${response.statusCode}  --------------  ');
        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('sucsess connection');
          debugPrint('${response.body}this is responnse');
          if (json.decode(response.body)["status"] == "success") {
            debugPrint('sucsess insert');
            return const Right(true);
          }
          debugPrint('sucsess but no data');

          return const Left(StatusRequest.sucsess_but_no_data);
        } else {
          debugPrint('server failuer');

          return const Left(StatusRequest.serverFailuer);
        }
      } else {
        debugPrint('off line');
        return const Left(StatusRequest.offlineFailuer);
      }
    } catch (e) {
      debugPrint(e.toString());
      return const Left(StatusRequest.unExpectedFailuer);
    }
  }

  Future<Either<StatusRequest, List>> postdatadynamic(
      {required String url, required data}) async {
    try {
      if (
          //true
          await checkInternet()) {
        var response = await http
            .post(Uri.parse(url), body: data)
            .timeout(const Duration(seconds: 15));

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (json.decode(response.body)["status"] == "success") {
            return Right(json.decode(response.body)["data"]);
          }

          return const Left(StatusRequest.sucsess_but_no_data);
        } else {
          return const Left(StatusRequest.serverFailuer);
        }
      } else {
        debugPrint('off line');
        return const Left(StatusRequest.offlineFailuer);
      }
    } on Exception catch (_) {
      return const Left(StatusRequest.unExpectedFailuer);
    }
  }

  Future<StatusRequest> postdataStatusrequestonly(
      {required String url, required data}) async {
    try {
      if (
          //true
          await checkInternet()) {
        var response = await http
            .post(Uri.parse(url), body: data)
            .timeout(const Duration(seconds: 15));

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (json.decode(response.body)["status"] == "success") {
            return StatusRequest.sucsses;
          }

          return StatusRequest.sucsess_but_no_data;
        } else {
          return StatusRequest.serverFailuer;
        }
      } else {
        debugPrint('off line');
        return StatusRequest.offlineFailuer;
      }
    } on Exception catch (_) {
      return (StatusRequest.unExpectedFailuer);
    }
  }

  Future<Either<StatusRequest, Note>> postdataNewNotes(
      {required String url, required data}) async {
    try {
      if (
          //true
          await checkInternet()) {
        var response = await http
            .post(Uri.parse(url), body: data)
            .timeout(Duration(seconds: 15));

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (json.decode(response.body)["status"] == "success") {
            return Right(Note(
                noteTitle: json.decode(response.body)["data"]["note_title"],
                noteBody: json.decode(response.body)["data"]["note_body"],
                noteImage: json.decode(response.body)["data"]["note_image"]));
          }

          return const Left(StatusRequest.sucsess_but_no_data);
        } else {
          debugPrint('server failuer');

          return const Left(StatusRequest.serverFailuer);
        }
      } else {
        debugPrint('off line');
        return const Left(StatusRequest.offlineFailuer);
      }
    } on Exception catch (_) {
      return const Left(StatusRequest.unExpectedFailuer);
    }
  }

  Future<Either<StatusRequest, User>> postForLogin(
      {required String url, required data}) async {
    try {
      if (
          //true
          await checkInternet()) {
        var response = await http
            .post(Uri.parse(url), body: data)
            .timeout(Duration(seconds: 15));

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (json.decode(response.body)["status"] == "success") {
            var userresponse = json.decode(response.body)["data"][0];

            return Right(User(
                userid: userresponse["users_id"],
                name: userresponse["user_name"],
                email: userresponse["user_email"],
                password: userresponse["user_password"],
                image: userresponse["user_image"]));
          }
          debugPrint('sucsess but no data');

          return const Left(StatusRequest.sucsess_but_no_data);
        } else {
          debugPrint('server failuer');

          return const Left(StatusRequest.serverFailuer);
        }
      } else {
        debugPrint('off line');
        return const Left(StatusRequest.offlineFailuer);
      }
    } on Exception catch (_) {
      return const Left(StatusRequest.unExpectedFailuer);
    }
  }

  Future<Either<StatusRequest, bool>> postdataWithfile(
      {required String url, required Map data, required File file}) async {
    try {
      if (await checkInternet()
          //  true
          ) {
        var request = http.MultipartRequest("POST", Uri.parse(url));
        //! name file here must be same file name in backend
        var length = await file.length();
        var stream = http.ByteStream(file.openRead());
        var requistfile = http.MultipartFile("file", stream, length,
            filename: basename(file.path));
        request.files.add(requistfile);
        data.forEach((key, value) {
          request.fields[key] = value;
        });
        var myrequest = await request.send();
        var response = await http.Response.fromStream(myrequest)
            .timeout(Duration(milliseconds: 30));

        if (myrequest.statusCode == 200 || myrequest.statusCode == 201) {
          debugPrint('sucsess connection');

          if (json.decode(response.body)["status"] == "success") {
            debugPrint('sucsess insert');
            return const Right(true);
          }
          debugPrint('sucsess but no data');
          return const Left(StatusRequest.sucsess_but_no_data);
        } else {
          debugPrint('server failuer');
          return const Left(StatusRequest.serverFailuer);
        }
      } else {
        debugPrint('off line');
        return const Left(StatusRequest.offlineFailuer);
      }
    } catch (_) {
      return const Left(StatusRequest.unExpectedFailuer);
    }
  }
}
