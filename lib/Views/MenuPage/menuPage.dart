import 'dart:convert';
import 'dart:developer';

import 'package:dine/Shared/Widgets/AppBar.dart';
import 'package:dine/Shared/Widgets/SliverAppBar.dart';
import 'package:dine/Storage/sharedPreference.dart';
import 'package:dine/ViewModels/MenuPageViewModel/menuPageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart' as prov;
import '../../Constants/staticConstants.dart';
import '../../Data/Repositories/MenuPage.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({super.key, required this.id});
  final String id;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {
  List<dynamic> keys = [];
  ScrollController controller = ScrollController();
  List<Widget> items = [];
  @override
  Widget build(BuildContext context) {
    final repo = prov.Provider.of<MenuPageData>(context, listen: false);
    repo.getRestaurant(widget.id, context);
    Constants.id = widget.id;
    return prov.Consumer<RestaurantBuilder>(
      builder: (context, ref, __) {
        if (repo.restaurant == null) {
          return const Scaffold(
              backgroundColor: (Colors.black),
              body: Center(
                child: CircularProgressIndicator(),
              ));
        }
        items = MenuPageViewModel().createMenu(repo.categoryDividedMenu!);
        return Scaffold(
          bottomNavigationBar:
              prov.Consumer<MenuPageData>(builder: (context, ref, child) {
            List<int> bottomData =
                MenuPageViewModel().getItemsAndAmount(context);
            return bottomData[0] == 0
                ? SizedBox()
                : GestureDetector(
                    onTap: () {
                      
                      setLocal(key: "cart", value: jsonEncode(ref.cart));
                      context.go("/menu/${Constants.id}/checkout");
                    },
                    child: Container(
                      color: Color(0xFF970040),
                      width: double.infinity,
                      height: 24 + 32,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Go to Cart (INR ${bottomData[1]})",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.shopping_cart_outlined,
                              color: Colors.white),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(1000)),
                            child: Center(
                              child: Text("${bottomData[0]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    // color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          )
                        ],
                      )),
                    ),
                  );
          }),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              CustomScrollView(controller: controller, slivers: [
                createCustomSliverAppBar(
                    restaurant: repo.restaurant!, controller: controller),
                SliverToBoxAdapter(
                    child: Column(
                  children:
                      List.generate(items.length, (index) => items[index]),
                )),
              ]),
              SizedBox(
                  width: double.infinity,
                  height: 84,
                  child: createAppBar(context))
            ],
          ),
        );
      },
    );
  }
}
