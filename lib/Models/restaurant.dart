import 'package:dine/Models/restaurantMenu.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  final String logo, name, city, state;
  final List<RestaurantMenu> menu;
  final String color;
  final List<String> tags;
  Restaurant(
      {required this.logo,
      required this.name,
      required this.city,
      required this.state,
      required this.color,
      required this.tags,
      required this.menu});

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
