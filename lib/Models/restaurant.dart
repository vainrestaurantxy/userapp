import 'package:dine/Models/restaurantMenu.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  String? logo;
  String? staffKey;
  bool? isRestaurant;
  String? name;
  String? city;
  String? state;
  String? phone;
  String? color;
  int? noTable = 100;
  String? tags;
  List<RestaurantMenu>? menu;

  Restaurant(
      {this.logo,
      this.name,
      this.city,
      this.state,
      this.color,
      this.tags,
      this.menu,
      this.isRestaurant,
      this.noTable,
      this.phone,
      this.staffKey});

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
