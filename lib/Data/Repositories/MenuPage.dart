import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine/Models/orders.dart';
import 'package:dine/Models/restaurantMenu.dart';
import 'package:dine/Network/network.dart';
import 'package:dine/Storage/sharedPreference.dart';
import 'package:dine/ViewModels/MenuPageViewModel/menuPageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/restaurant.dart';

class MenuPageData extends ChangeNotifier {
  Restaurant? restaurant;
  String? name;
  String? phone;
  int? tableNo;
  List<String>? sugg;
  List<Orders>? orders;
  Map<String, List<RestaurantMenu>>? categoryDividedMenu;
  Map<String, int> cart = {};
  Map<String, RestaurantMenu> code_item =
      {}; //code_item stores a map of restaurant name as key and res menu as value
  Network network = Network();
  Map<String, int> order = {};
  bool myOrders = false;
  refresh() {
    notifyListeners();
  }

  double getTotal() {
    double price = 0.0;
    for (MapEntry<String, int> a in cart.entries) {
      if ((code_item[a.key]?.tax ?? 0) == 5) {
        price += (((code_item[a.key]?.price) ?? 0) * (cart[(a.key)] as int));
      } else {
        price += ((code_item[a.key]?.price ?? 0) / 1.01);
      }
    }

    return double.parse(price.toStringAsFixed(2));
  }

  double getDiscount() {
    double discount = 0.0;
    for (MapEntry<String, int> a in cart.entries) {
      discount += (((code_item[a.key]?.price ?? 0) * 0.05) +
              (code_item[a.key]?.price ?? 0)) *
          (cart[(a.key)] as int) *
          ((code_item[a.key]?.discount ?? 0) / 100);
    }

    return double.parse(discount.toStringAsFixed(2));
  }

  Future<void> getRestaurant(String id, context) async {
    Map<String, dynamic>? json = await network.get("Restaurants", id);
    restaurant = Restaurant.fromJson(json!);
    categoryDividedMenu = MenuPageViewModel().reArrangeCategory(restaurant: restaurant!);
    code_item = MenuPageViewModel().mapCodeToItem(restaurant!.menu!);
    notifyListeners();
    final builder = Provider.of<RestaurantBuilder>(context, listen: false);
    builder.refreshRestaurant();
  }

  void addOnTap({required String name}) {
    RestaurantMenu item =
        restaurant!.menu!.where((element) => element.name == name).first;
    item.itemCount = ((item.itemCount) ?? 0) + 1;
    cart[item.name ?? ""] = (cart[item.name] ?? 0) + 1;
    notifyListeners();
  }

  void subOnTap({required String name}) {
    RestaurantMenu item =
        restaurant!.menu!.where((element) => element.name == name).first;
    item.itemCount = ((item.itemCount) ?? 0) - 1;
    cart[item.name ?? ""] = (cart[item.name] ?? 0) - 1;
    notifyListeners();
  }

  void confirmOrder() {
    // log(cart.entries.length.toString());
    // order = cart.map((key, value) {
    //   return MapEntry(key, (order[key] ?? 0) + value);
    // });

    // setLocal(key: 'order', value: jsonEncode(order));
    // remove(key: 'cart');
    // cart = {};
    // restaurant!.menu!.map((e) {
    //   e.itemCount = 0;
    // });
    // notifyListeners();
  }

  Future<void> setUser(
      {required String macAdderess,
      required String name,
      required String phoneno,
      required int tableNo}) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(macAdderess)
        .set({"name": name, "phoneNo": phoneno, "tableNo": tableNo});
  }

  getUser(macAddress) async {
    DocumentSnapshot<Map<String, dynamic>> json = await FirebaseFirestore
        .instance
        .collection("Users")
        .doc(macAddress)
        .get();
    name = json.data()?["name"] ?? "";
    phone = json.data()?["phoneNo"] ?? "";
    tableNo = json.data()?["tableNo"] ?? "";
    notifyListeners();
  }

  Future<void> getData(Restaurant res) async {
    final id = await getLocal(key: "id");
    //log("$id : NULL ");
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Category').doc(id).get();

    if (snapshot.exists) {
      log((snapshot.data()?['categories'] ?? []).toString());
      List<String> tempList =
          ((snapshot.data()?['categories'] ?? []) as List<dynamic>)
              .map((e) => e as String)
              .toList();
      res.tags = tempList;
      // print('res tags : ${res.tags!.length.toString()}');
      notifyListeners();
    }
  }
}

class RestaurantBuilder extends ChangeNotifier {
  refreshRestaurant() {
    notifyListeners();
  }
}
