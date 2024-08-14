import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User{
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'Name')
  String? Name;
  @JsonKey(name: 'MobileNo')
  int? MobileNo;

  User({this.id,this.Name,this.MobileNo});

  factory User.fromJson(Map<String,dynamic> json)=> _$UserFromJson(json);
  Map<String ,dynamic> toJson()=>_$UserToJson(this);
}