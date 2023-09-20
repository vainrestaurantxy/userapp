import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/Models/orders.dart';
import 'package:dine/Storage/sharedPreference.dart';
import 'package:dine/ViewModels/MenuPageViewModel/menuPageViewModel.dart';
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

    list.add(order.toJson());
    await FirebaseFirestore.instance
        .collection("Restaurants")
        .doc(id)
        .collection("Orders")
        .doc(
            '${DateTime.now().toUtc().day}|${DateTime.now().toUtc().month}|${DateTime.now().toUtc().year}')
        .set({"order": list});
  }

  getOrder(String id, context) async {
    DocumentSnapshot<Map<String, dynamic>> json = await FirebaseFirestore
        .instance
        .collection("Restaurants")
        .doc(id)
        .collection("Orders")
        .doc(
            '${DateTime.now().toUtc().day}|${DateTime.now().toUtc().month}|${DateTime.now().toUtc().year}')
        .get();
    List<Orders>? order = json.data()?["orders"].map((v) => Orders.fromJson(v));
    order?.removeWhere((element) {
      return element.macAdd != Constants.macAddress;
    });
    order?.removeWhere((element) {
      return element.orderStatus =="";
    });
    Provider.of<MenuPageData>(context, listen: false).orders = order ;
  }
}