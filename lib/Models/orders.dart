import 'package:dine/Models/restaurantMenu.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders.g.dart';

@JsonSerializable()
class Orders {
  int? orderNo;
  String? orderStatus;
  int? tableNo;
  List<RestaurantMenu>? items;
  String? customerName;
  double? price;
  Map<String, int>? quanntity;
  double? tax;
  double? discount;
  String? contactNo;
  String? macAdd;
  double? totalPrice;

  Orders(
      {this.orderNo,
      this.orderStatus,
      this.tableNo,
      this.contactNo,
      this.customerName,
      this.discount,
      this.items,
      this.price,
      this.quanntity,
      this.tax,
      this.macAdd,
      this.totalPrice});

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}
