import 'package:dine/Views/MenuPage/widgets.dart';
import 'package:flutter/material.dart';


import '../../Models/restaurant.dart';
import '../../Models/restaurantMenu.dart';

class MenuPageViewModel {
  static List<GlobalKey> keys = [];
  Map<String, List<RestaurantMenu>> reArrangeCategory(
      {required Restaurant restaurant}) {
    Map<String, List<RestaurantMenu>> categoryDividedMenu = {};
    for (var item in restaurant.menu) {
      if (categoryDividedMenu[item.category.name] == null) {
        categoryDividedMenu[item.category.name] = [];
      }
      categoryDividedMenu[item.category.name]!.add(item);
    }
    return categoryDividedMenu;
  }

  List<Widget> createMenu(
      Map<String, List<RestaurantMenu>> categoryDividedMenu) {
    List<Widget> items = [];

    for (var i in categoryDividedMenu.entries) {
      keys.add(GlobalKey());
      items.add(
        ExpansionTile(
          key: keys[keys.length - 1],
          title: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              i.key,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          children: List.generate(
              i.value.length,
              (index) => Item(
                  image: i.value[index].image,
                  desc: i.value[index].description,
                  price: i.value[index].price,
                  name: i.value[index].name,
                  tags: i.value[index].tags)),
          childrenPadding: EdgeInsets.all(8),
          initiallyExpanded: true,
        ),
      );
    }
    return items;
  }
}
