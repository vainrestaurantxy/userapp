import 'package:json_annotation/json_annotation.dart';


part 'tag.g.dart';

@JsonSerializable()
class Tags {
  final String code, name, icon;

  Tags({
    required this.code,
    required this.name,
    required this.icon,
  });

  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);

  Map<String, dynamic> toJson() => _$TagsToJson(this);
}
