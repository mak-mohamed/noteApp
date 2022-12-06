import 'package:noteapp/core/constants/const_api.dart';
import 'package:noteapp/core/statusrequest.dart';
import 'package:noteapp/data/crud.dart';

Future<StatusRequest> deleteNoteData({required String noteid}) async {
  return await Crud().postdataStatusrequestonly(
      url: ConstApi.constdeletenote, data: {"idnote": noteid});
}
