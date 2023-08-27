import 'dart:developer';

import 'package:dine/Models/restaurantMenu.dart';
import 'package:dine/Network/network.dart';
import 'package:dine/ViewModels/MenuPageViewModel/menuPageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/restaurant.dart';

class MenuPageData extends ChangeNotifier {
  Restaurant? restaurant;
  Map<String, List<RestaurantMenu>>? categoryDividedMenu;
  Map<String, int> cart = {};
  Map<String, RestaurantMenu> code_item = {};
  Network network = Network();
  Map<String, int> order = {};

  Future<void> getRestaurant(String id, context) async {
    Map<String, dynamic>? json = await network.get("Restaurants", id);
    restaurant = Restaurant.fromJson(json!);
    categoryDividedMenu =
        MenuPageViewModel().reArrangeCategory(restaurant: restaurant!);
    code_item = MenuPageViewModel().mapCodeToItem(restaurant!.menu);
    final builder = Provider.of<RestaurantBuilder>(context, listen: false);
    builder.refreshRestaurant();
  }

  void addOnTap({required String code}) {
    RestaurantMenu item =
        restaurant!.menu.where((element) => element.code == code).first;
    item.itemCount = (item.itemCount) + 1;
    cart[item.code] = (cart[item.code] ?? 0) + 1;
    notifyListeners();
  }

  void subOnTap({required String code}) {
    RestaurantMenu item =
        restaurant!.menu.where((element) => element.code == code).first;
    item.itemCount = (item.itemCount) - 1;
    cart[item.code] = (cart[item.code] ?? 0) - 1;
    notifyListeners();
  }

  void confirmOrder() {
    log(cart.entries.length.toString());
    order = cart.map((key, value) {
      return MapEntry(key, (order[key] ?? 0) + value);
    });

    cart = {};
    restaurant!.menu.map((e) {
      e.itemCount = 0;
    });
    notifyListeners();
  }
}

class RestaurantBuilder extends ChangeNotifier {
  refreshRestaurant() {
    notifyListeners();
  }
}
