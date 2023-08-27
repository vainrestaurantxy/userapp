// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      logo: json['logo'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      color: json['color'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      menu: (json['menu'] as List<dynamic>)
          .map((e) => RestaurantMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'logo': instance.logo,
      'name': instance.name,
      'city': instance.city,
      'state': instance.state,
      'menu': instance.menu,
      'color': instance.color,
      'tags': instance.tags,
    };
