import 'package:json_annotation/json_annotation.dart';
part 'productcategory.g.dart';

@JsonSerializable()
class Productcategory{
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'Name')
  String? Name;


  Productcategory({this.id,this.Name});

  factory Productcategory.fromJson(Map<String,dynamic> json)=> _$ProductcategoryFromJson(json);
  Map<String ,dynamic> toJson()=>_$ProductcategoryToJson(this);
}