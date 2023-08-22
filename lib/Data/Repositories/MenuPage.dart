import 'dart:convert';

import 'package:dine/Network/network.dart';
import 'package:flutter/material.dart';

import '../../Models/restaurant.dart';

class MenuPage extends ChangeNotifier {
  Restaurant? restaurant;

  getRestaurant(String id) async {
    restaurant = Restaurant.fromJson(await Network().get("Restaurants", id));
    notifyListeners();
  }
}
