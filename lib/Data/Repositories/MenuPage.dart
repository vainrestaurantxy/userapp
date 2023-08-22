import 'dart:developer';

import 'package:dine/Models/restaurantMenu.dart';
import 'package:dine/Network/network.dart';
import 'package:dine/ViewModels/MenuPageViewModel/menuPageViewModel.dart';
import 'package:flutter/material.dart';

import '../../Models/restaurant.dart';

class MenuPageData extends ChangeNotifier {
  Restaurant? restaurant;
  Map<String, List<RestaurantMenu>>? categoryDividedMenu;
  Network network = Network();

  Future<void> getRestaurant(String id) async {
    Map<String, dynamic>? json = await network.get("Restaurants", id);

    restaurant = Restaurant.fromJson(json!);
    categoryDividedMenu =
        MenuPageViewModel().reArrangeCategory(restaurant: restaurant!);
    notifyListeners();
  }
}
