import 'package:agenda_proautismo/common/requests.dart';
import 'package:agenda_proautismo/common/result.dart';
import 'package:agenda_proautismo/models/new_user.dart';

Future<Result<NewUserRes?>> newUser(NewUserReq data) async {
  return await Requests.postRes(
      mkurl("/users/sign_up"),data,
      NewUserRes.fromJson);
}