// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewUserReq _$NewUserReqFromJson(Map<String, dynamic> json) => NewUserReq(
      json['username'] as String,
      json['password'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
    );

Map<String, dynamic> _$NewUserReqToJson(NewUserReq instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };

NewUserRes _$NewUserResFromJson(Map<String, dynamic> json) => NewUserRes()
  ..UserId = json['UserId'] as int?
  ..UserId123 = json['UserId123'] as int?;

Map<String, dynamic> _$NewUserResToJson(NewUserRes instance) =>
    <String, dynamic>{
      'UserId': instance.UserId,
      'UserId123': instance.UserId123,
    };
