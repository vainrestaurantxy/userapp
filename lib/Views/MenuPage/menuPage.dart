import 'dart:developer';

import 'package:dine/Shared/Widgets/AppBar.dart';
import 'package:dine/Shared/Widgets/SliverAppBar.dart';
import 'package:dine/Views/MenuPage/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {
  Map<String, List<dynamic>> catog = {
    "Recommended": [
      {
        "image":
            "https://th.bing.com/th/id/OIP.nsapv4aiFwUPm_lYYf1dTQHaE8?pid=ImgDet&w=3888&h=2592&rs=1",
        "desc":
            "Deep fried egg in an egg curry with spices and vegetables served with hot wine and tasty fragrance.",
        "name": "Kothu Porotta",
        "price": 1400,
        "tags": ["bestseller", "veg"]
      },
      {
        "image":
            "https://th.bing.com/th/id/OIP.nsapv4aiFwUPm_lYYf1dTQHaE8?pid=ImgDet&w=3888&h=2592&rs=1",
        "desc":
            "Deep fried egg in an egg curry with spices and vegetables served with hot wine and tasty fragrance.",
        "name": "Kothu Porotta",
        "price": 1400,
        "tags": ["bestseller", "veg"]
      },
      {
        "image":
            "https://th.bing.com/th/id/OIP.nsapv4aiFwUPm_lYYf1dTQHaE8?pid=ImgDet&w=3888&h=2592&rs=1",
        "desc":
            "Deep fried egg in an egg curry with spices and vegetables served with hot wine and tasty fragrance.",
        "name": "Kothu Porotta",
        "price": 1400,
        "tags": ["bestseller", "veg"]
      }
    ],
    "Taj Special": [
      {
        "image":
            "https://th.bing.com/th/id/OIP.nsapv4aiFwUPm_lYYf1dTQHaE8?pid=ImgDet&w=3888&h=2592&rs=1",
        "desc":
            "Deep fried egg in an egg curry with spices and vegetables served with hot wine and tasty fragrance.",
        "name": "Kothu Porotta",
        "price": 1400,
        "tags": ["bestseller", "veg"]
      }
    ]
  };

  List<Widget> items = [];
  @override
  void initState() {
    for (var element in catog.entries) {
      items.add(Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          element.key,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ));
      for (var element2 in element.value) {
        items.add(Item(
          image: element2["image"],
          desc: element2["desc"],
          name: element2["name"],
          price: element2["price"],
          tags: element2["tags"],
        )
        );
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomScrollView(slivers: [
            customSliverAppBar,
            SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: items.length,
              (context, index) => items[index],
            ))
          ]),
          SizedBox(width: double.infinity, height: 84, child: customAppbar)
        ],
      ),
    );
  }
}
