// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
      orderNo: json['orderNo'] as int?,
      orderStatus: json['orderStatus'] as String?,
      tableNo: json['tableNo'] as int?,
      contactNo: json['contactNo'] as String?,
      customerName: json['customerName'] as String?,
      discount: (json['discount'] as num?)?.toDouble(),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => RestaurantMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: (json['price'] as num?)?.toDouble(),
      quanntity: (json['quanntity'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as int),
      ),
      tax: (json['tax'] as num?)?.toDouble(),
      macAdd: json['macAdd'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'orderNo': instance.orderNo,
      'orderStatus': instance.orderStatus,
      'tableNo': instance.tableNo,
      'items': instance.items,
      'customerName': instance.customerName,
      'price': instance.price,
      'quanntity': instance.quanntity,
      'tax': instance.tax,
      'discount': instance.discount,
      'contactNo': instance.contactNo,
      'macAdd': instance.macAdd,
      'totalPrice': instance.totalPrice,
    };
