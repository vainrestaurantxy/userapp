import 'dart:convert';

import 'package:dine/Models/restaurant.dart';
import 'package:dine/Shared/Widgets/AppBar.dart';
import 'package:dine/Shared/Widgets/SliverAppBar.dart';
import 'package:dine/Storage/sharedPreference.dart';
import 'package:dine/ViewModels/MenuPageViewModel/menuPageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart' as prov;
import '../../Utils/Constants/staticConstants.dart';
import '../../Data/Repositories/MenuPage.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({super.key, required this.id});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {
  Restaurant restaurant = Restaurant();
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
        print("items:" + items.toString());
        restaurant = repo.restaurant!;
        repo.getData(restaurant);
        return Scaffold(
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              CustomScrollView(controller: controller, slivers: [
                createCustomSliverAppBar(
                    rest: repo.restaurant, controller: controller),
                SliverToBoxAdapter(
                  child: Column(
                    children:
                        List.generate(items.length, (index) => items[index]),
                  ),
                ),
              ]),
              SizedBox(
                  width: double.infinity,
                  height: 84,
                  child: createAppBar(context)),
              prov.Consumer<MenuPageData>(
                builder: (context, ref, child) {
                  List<int> bottomData =
                      MenuPageViewModel().getItemsAndAmount(context);
                  return bottomData[0] == 0
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GestureDetector(
                              onTap: () {
                                setLocal(
                                    key: "cart", value: jsonEncode(ref.cart));
                                context.go("/menu/${Constants.id}/checkout");
                              },
                              child: Container(
                                width: 151,
                                height: 48,
                                decoration: BoxDecoration(
                                    color: const Color(0xff88001f),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.shopping_cart_outlined,
                                        color: Colors.white),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'View Cart (${bottomData[0]})',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
