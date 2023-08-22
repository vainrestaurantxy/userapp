// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurantMenu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantMenu _$RestaurantMenuFromJson(Map<String, dynamic> json) =>
    RestaurantMenu(
      code: json['code'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tags.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RestaurantMenuToJson(RestaurantMenu instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
      'tags': instance.tags,
      'category': instance.category,
    };
