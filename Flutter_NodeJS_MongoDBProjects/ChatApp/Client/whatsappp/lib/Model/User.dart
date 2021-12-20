import 'package:json_annotation/json_annotation.dart';
part 'User.g.dart';

@JsonSerializable()
class User {
   User(this.name, this.email,this.password,this.pic);
   String? name;
   String email;
   String? password;
   String? pic;
   String? token;
   String? id;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}