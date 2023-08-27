import 'dart:convert';
import 'dart:developer';

import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/Storage/sharedPreference.dart';
import 'package:dine/ViewModels/MenuPageViewModel/menuPageViewModel.dart';
import 'package:provider/provider.dart';

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
}
