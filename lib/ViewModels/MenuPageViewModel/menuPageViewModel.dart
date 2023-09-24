import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/Views/MenuPage/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';
import '../../Models/restaurant.dart';
import '../../Models/restaurantMenu.dart';

class MenuPageViewModel extends ChangeNotifier {
  static Map<String, GlobalKey> keys = {};
  List<String> selectedTags = [];

  Map<String, List<RestaurantMenu>> reArrangeCategory(
      {required Restaurant restaurant}) {
    Map<String, List<RestaurantMenu>> categoryDividedMenu = {};
    for (var item in restaurant.menu!) {
      if (categoryDividedMenu[item.category] == null) {
        categoryDividedMenu[item.category ?? ""] = [];
      }
      categoryDividedMenu[item.category]!.add(item);
    }

    return categoryDividedMenu;
  }

  Map<String, RestaurantMenu> mapCodeToItem(List<RestaurantMenu> menu) {
    Map<String, RestaurantMenu> map = {};
    for (RestaurantMenu index in menu) {
      map[index.name ?? ""] = index;
    }
    return map;
  }

  List<Widget> createMenu(
      Map<String, List<RestaurantMenu>> categoryDividedMenu) {
    List<Widget> items = [];
    if (selectedTags == null) {
      for (var i in categoryDividedMenu.entries) {
        // keys.add(GlobalKey());
        items.add(
          ExpansionTile(
            // key: keys[keys.length - 1],
            title: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                i.key,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            childrenPadding: const EdgeInsets.all(8),
            initiallyExpanded: true,
            children: List.generate(
                i.value.length,
                (index) => Item(
                    image: i.value[index].image ?? "",
                    desc: i.value[index].description ?? "",
                    price: i.value[index].price ?? 0,
                    name: i.value[index].name ?? "",
                    code: i.value[index].code ?? "",
                    tags: i.value[index].tags ?? [])),
          ),
        );
      }
    } else {
      for (var i in categoryDividedMenu.entries) {
        // keys.add(GlobalKey());
        items.add(
          ExpansionTile(
            key: keys[keys.length - 1],
            title: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                i.key,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            childrenPadding: const EdgeInsets.all(8),
            initiallyExpanded: true,
            children: List.generate(
                i.value.length,
                (index) => Item(
                    image: i.value[index].image ?? "",
                    desc: i.value[index].description ?? "",
                    price: i.value[index].price ?? 0,
                    name: i.value[index].name ?? "",
                    code: i.value[index].code ?? "",
                    tags: i.value[index].tags ?? [])),
          ),
        );
      }
    }

    log('menu ${categoryDividedMenu['Grills']![0].tags.toString()}');
    log('selectedTags: $selectedTags');
    return items;
  }

  List<int> getItemsAndAmount(context) {
    final prov = Provider.of<MenuPageData>(context, listen: false);
    int items = 0;
    int amount = 0;
    print(prov.cart);
    for (var i in prov.cart.entries) {
      String code = i.key;
      int count = i.value;
      items += count;
      print(prov.code_item[code]);
      amount += count * (prov.code_item[code]?.price ?? 0);
    }
    return [items, amount];
  }
}
