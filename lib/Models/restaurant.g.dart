// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      logo: json['logo'] as String?,
      name: json['name'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      color: json['color'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      menu: (json['menu'] as List<dynamic>?)
          ?.map((e) => RestaurantMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
      isRestaurant: json['isRestaurant'] as bool?,
      noTable: json['noTable'] as int?,
      phone: json['phone'] as String?,
      staffKey: json['staffKey'] as String?,
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'logo': instance.logo,
      'staffKey': instance.staffKey,
      'isRestaurant': instance.isRestaurant,
      'name': instance.name,
      'city': instance.city,
      'state': instance.state,
      'phone': instance.phone,
      'color': instance.color,
      'noTable': instance.noTable,
      'tags': instance.tags,
      'menu': instance.menu,
    };
