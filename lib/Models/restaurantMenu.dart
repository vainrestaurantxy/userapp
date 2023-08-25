import 'package:dine/Models/tag.dart';
import 'package:json_annotation/json_annotation.dart';

import 'category.dart';

part 'restaurantMenu.g.dart';

@JsonSerializable()
class RestaurantMenu {
  final String code, name, description, image;
  final int price;
  final List<Tags> tags;
  int itemCount = 0;
  final Category category;

  RestaurantMenu(
      {required this.code,
      required this.name,
      required this.price,
      required this.description,
      this.itemCount = 0,
      required this.tags,
      required this.image,
      required this.category});

  factory RestaurantMenu.fromJson(Map<String, dynamic> json) =>
      _$RestaurantMenuFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantMenuToJson(this);
}
