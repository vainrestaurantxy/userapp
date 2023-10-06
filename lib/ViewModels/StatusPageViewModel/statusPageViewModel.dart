import 'dart:convert';
import 'dart:developer';

import 'package:dine/Utils/Constants/staticConstants.dart';
import 'package:provider/provider.dart';

import '../../Data/Repositories/MenuPage.dart';
import '../../Storage/sharedPreference.dart';

class StatusPageViewModel {
  List<int> getItemsAndAmount(context) {
    final prov = Provider.of<MenuPageData>(context, listen: false);
    int items = 0;
    int amount = 0;
    // print(prov.cart);
    // print(prov.code_item);
    for (var i in prov.order.entries) {
      String code = i.key;
      int count = i.value;
      items += count;
      amount += count * (prov.code_item[code]!.price ?? 0);
    }
    return [items, amount];
  }

  getCartandOrder(context) async {
    final repo = Provider.of<MenuPageData>(context, listen: false);
    // String id = await getLocal(key: "id");
    await repo.getRestaurant(Constants.id, context);
    String json = await getLocal(key: "cart");
    if (json != "") {
      Map<String, dynamic> decodedJson = jsonDecode(json);
      Map<String, int> cartMap = {};
      decodedJson.forEach((key, value) {
        cartMap[key] = value as int;
      });
      repo.cart = cartMap;
    }
    json = await getLocal(key: "order");

    if (json != "") {
      Map<String, dynamic> decodedJson = jsonDecode(json);
      Map<String, int> cartMap = {};
      decodedJson.forEach((key, value) {
        cartMap[key] = value as int;
      });
      repo.order = cartMap;
    }
    repo.refresh();
  }
}
