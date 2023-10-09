import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/Views/MenuPage/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';
import '../../Models/restaurant.dart';
import '../../Models/restaurantMenu.dart';

class MenuPageViewModel extends ChangeNotifier {
  static Map<String, GlobalKey> keys = {};
  String selectedTags = "Ayush";
  static String tag = "";
  static bool boolTag = false;
  int selectedFilterIndex = -1;

  Map<String, List<RestaurantMenu>> reArrangeCategory({required Restaurant restaurant}) {
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

  List<Widget> createMenu(Map<String, List<RestaurantMenu>> categoryDividedMenu) {
    List<Widget> items = [];
    // print("object");
     print("from create menu $tag");
     print("from create menu $boolTag");


    if ((tag == "Veg" || tag == "Non Veg" || tag=="" || tag=="Drinks" || tag=="Recommended" || tag=="Bestseller" || tag=="New") && boolTag!=true) {
      for (var i in categoryDividedMenu.entries) {
        // keys.add(GlobalKey());
        GlobalKey key = GlobalKey();
        keys[i.key] = key;
        items.add(
          ExpansionTile(
            key: keys[i.key],
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
    else if(boolTag ==true && tag=="Drinks"){
      print("fetching drinks category");
      for (var i in categoryDividedMenu.entries) {
        GlobalKey key = GlobalKey();
        keys[i.key] = key;
        List<RestaurantMenu> filterdItems = i.value.where((element) => (element.tags?[0] ?? "") == "Non Alcoholic").toList();
        filterdItems= filterdItems + i.value.where((element) => (element.tags?[0] ?? "") == "Alcoholic").toList();
        items.add(ExpansionTile(
          key: keys[i.key],
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
              filterdItems.length,
                  (index) => Item(
                  image: filterdItems[index].image ?? "",
                  desc: filterdItems[index].description ?? "",
                  price: filterdItems[index].price ?? 0,
                  name: filterdItems[index].name ?? "",
                  code: filterdItems[index].code ?? "",
                  tags: filterdItems[index].tags ?? [])),
        ),);
      }
    }
    else if(boolTag ==true){
      for (var i in categoryDividedMenu.entries) {
        GlobalKey key = GlobalKey();
        keys[i.key] = key;
        List<RestaurantMenu> filterdItems = i.value.where((element) => (element.tags!.contains(tag))).toList();
        items.add(ExpansionTile(
            key: keys[i.key],
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
                filterdItems.length,
                (index) => Item(
                    image: filterdItems[index].image ?? "",
                    desc: filterdItems[index].description ?? "",
                    price: filterdItems[index].price ?? 0,
                    name: filterdItems[index].name ?? "",
                    code: filterdItems[index].code ?? "",
                    tags: filterdItems[index].tags ?? [])),
          ),);
      }
    }
    // log('menu ${categoryDividedMenu['Grills']![0].tags.toString()}');
    // log('selectedTags: $selectedTags');
    return items;
  }

  List<int> getItemsAndAmount(context) {
    final prov = Provider.of<MenuPageData>(context, listen: false);
    int items = 0;
    int amount = 0;
    //  print(prov.cart);
    for (var i in prov.cart.entries) {
      String code = i.key;
      int count = i.value;
      items += count;
      //  print(prov.code_item[code]);
      amount += count * (prov.code_item[code]?.price ?? 0);
    }
    return [items, amount];
  }
}
