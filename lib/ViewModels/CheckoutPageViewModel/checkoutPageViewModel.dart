import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/Models/orders.dart';
import 'package:dine/Storage/sharedPreference.dart';
import 'package:dine/ViewModels/MenuPageViewModel/menuPageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/restaurantMenu.dart';
import '../../Utils/Constants/staticConstants.dart';

class CheckoutViewModel {
  getItemsAndAmount(context) {
    return MenuPageViewModel().getItemsAndAmount(context);
  }

  clearCart(context) {
    final repo = Provider.of<MenuPageData>(context, listen: false);
    repo.confirmOrder();
  }

  getCart(context) async {
    final repo = Provider.of<MenuPageData>(context, listen: false);
    String id = await getLocal(key: "id");
    await repo.getRestaurant(id, context);
    String json = await getLocal(key: "cart");
    Map<String, dynamic> decodedJson = jsonDecode(json);
    repo.refresh();
    Map<String, int> cartMap = {};
    decodedJson.forEach((key, value) {
      cartMap[key] = value as int;
    });
    repo.cart = cartMap;
  }

  placeOrder(String id, Orders order) async {
    DocumentSnapshot<Map<String, dynamic>> json = await FirebaseFirestore
        .instance
        .collection("Restaurants")
        .doc(id)
        .collection("Orders")
        .doc(
            '${DateTime.now().toUtc().day}|${DateTime.now().toUtc().month}|${DateTime.now().toUtc().year}')
        .get();
    List<dynamic> list = json.data()?["order"] ?? [];
    order.orderNo = list.length;
    // print("list" + list.toString());
    List<dynamic> menulist = order.items!.map((e) {
      return e.toJson();
    }).toList();
    Map<String, dynamic> orderJson = order.toJson();
    orderJson["items"] = menulist;

    //  print(order.toJson());
    list.add(orderJson);
    await FirebaseFirestore.instance
        .collection("Restaurants")
        .doc(id)
        .collection("Orders")
        .doc(
            '${DateTime.now().toUtc().day}|${DateTime.now().toUtc().month}|${DateTime.now().toUtc().year}')
        .set({"order": list});
  }

  // getOrder(String id, context) async {
  //   DocumentSnapshot<Map<String, dynamic>> json = await FirebaseFirestore
  //       .instance
  //       .collection("Restaurants")
  //       .doc(id)
  //       .collection("Orders")
  //       .doc(
  //           '${DateTime.now().toUtc().day}|${DateTime.now().toUtc().month}|${DateTime.now().toUtc().year}')
  //       .get();
  //   List<Orders>? order = json.data()?["orders"].map((v) => Orders.fromJson(v));
  //   order?.removeWhere((element) {
  //     return element.macAdd != Constants.macAddress;
  //   });
  //   order?.removeWhere((element) {
  //     return element.orderStatus == "";
  //   });
  //   Provider.of<MenuPageData>(context, listen: false).orders = order;
  // }

  Stream<List<Orders>> getOrderStream(String id) {
    return FirebaseFirestore.instance
        .collection("Restaurants")
        .doc(id)
        .collection("Orders")
        .doc(
            '${DateTime.now().toUtc().day}|${DateTime.now().toUtc().month}|${DateTime.now().toUtc().year}')
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;

        final List<dynamic> orderList = data["order"];
        // final latestOrder = orderList[orderList.length - 1];
        // log('latest $latestOrder');
        // print(data);
        // Filter orders by macAddress and non-empty orderStatus
        final filteredOrders = orderList
            .where((orderData) =>
                orderData["macAdd"] == Constants.macAddress &&
                orderData["orderStatus"] != "Order Paid")
            .map((orderData) => Orders.fromJson(orderData))
            .toList();
        // print("Filtered Orders");
        // print(filteredOrders);
        return filteredOrders;
      } else {
        // If the document doesn't exist, return an empty list
        return <Orders>[];
      }
    });
  }

  getSuggestions(context) {
    // getCart(context);
    final prov = Provider.of<MenuPageData>(context, listen: false);
    prov.cart.removeWhere((key, value) => value == 0);
    List<RestaurantMenu> menuCorrected =
        prov.cart.entries.map((e) => prov.code_item[e.key]!).toList();
    List<String> suggestion = [];
    menuCorrected.forEach((e) => suggestion.addAll(e.recommendedWith ?? []));
    Provider.of<MenuPageData>(context, listen: false).sugg = suggestion;
  }
}
