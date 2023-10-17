// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurantMenu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantMenu _$RestaurantMenuFromJson(Map<String, dynamic> json) =>
    RestaurantMenu(
      category: json['category'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      discount: json['discount'] as int?,
      itemCount: json['itemCount'] as int?,
      itemType: json['itemType'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      recommendedWith: (json['recommendedWith'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tax: json['tax'] as int?,
    );

Map<String, dynamic> _$RestaurantMenuToJson(RestaurantMenu instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
      'itemCount': instance.itemCount,
      'itemType': instance.itemType,
      'tax': instance.tax,
      'discount': instance.discount,
      'tags': instance.tags,
      'recommendedWith': instance.recommendedWith,
      'category': instance.category,
    };
