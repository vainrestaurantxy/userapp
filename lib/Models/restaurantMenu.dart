
import 'package:json_annotation/json_annotation.dart';



part 'restaurantMenu.g.dart';

@JsonSerializable()
class RestaurantMenu {
  String? code, name, description, image;
  int? price;

  int? itemCount = 0;

  String? itemType;

  int? tax = 0;
  int? discount = 0;

  List<String>? tags;

  List<String>? recommendedWith;
  String? category;

  RestaurantMenu(
      {this.category,
      this.code,
      this.name,
      this.description,
      this.image,
      this.discount,
      this.itemCount,
      this.itemType,
      this.price,
      this.recommendedWith,
      this.tags,
      this.tax});

  factory RestaurantMenu.fromJson(Map<String, dynamic> json) =>
      _$RestaurantMenuFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantMenuToJson(this);
}
