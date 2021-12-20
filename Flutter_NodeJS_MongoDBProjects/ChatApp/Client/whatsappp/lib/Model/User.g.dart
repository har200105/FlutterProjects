// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['name'] as String?,
    json['email'] as String,
    json['password'] as String?,
    json['pic'] as String?,
  )
    ..token = json['token'] as String?
    ..id = json['id'] as String?;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'pic': instance.pic,
      'token': instance.token,
      'id': instance.id,
    };
