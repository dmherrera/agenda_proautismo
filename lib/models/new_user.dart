
import 'package:json_annotation/json_annotation.dart';
part 'new_user.g.dart';

@JsonSerializable()
class NewUserReq{
  String username;
  String password;
  String firstName;
  String lastName;
  NewUserReq(this.username, this.password, this.firstName, this.lastName);
  static NewUserReq fromJson(Map<String, dynamic> json) => _$NewUserReqFromJson(json);
  Map<String, dynamic> toJson() => _$NewUserReqToJson(this);
}


@JsonSerializable()
class NewUserRes{
  int? UserId;
  int? UserId123;
  static NewUserRes fromJson(Map<String, dynamic> json) => _$NewUserResFromJson(json);
  Map<String, dynamic> toJson() => _$NewUserResToJson(this);
}