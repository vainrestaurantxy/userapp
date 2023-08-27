import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/Storage/sharedPreference.dart';
import 'package:dine/ViewModels/StatusPageViewModel/statusPageViewModel.dart';
import 'package:dine/Views/CheckoutPage/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import '../../Constants/staticConstants.dart';
import '../../Models/restaurant.dart';
import '../../ViewModels/MenuPageViewModel/menuPageViewModel.dart';

class Status extends StatelessWidget {
  const Status({super.key});

  getRestaurant(context) async {
    final prov = Provider.of<MenuPageData>(context, listen: false);
    String id = await getLocal(key: "id");
    await prov.getRestaurant(id, context);
    StatusPageViewModel().getCartandOrder(context);
    Constants.id = id;
  }

  @override
  Widget build(BuildContext context) {
    getRestaurant(context);
    final prov = Provider.of<MenuPageData>(context, listen: false);
    Restaurant? restaurant = prov.restaurant;
    return Consumer<RestaurantBuilder>(builder: (context, ref, child) {
      if (prov.restaurant == null) {
        return const Scaffold(
            backgroundColor: (Colors.black),
            body: Center(
              child: CircularProgressIndicator(),
            ));
      }
      restaurant = prov.restaurant;
      return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Text("STATUS",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              )),
          elevation: 0,
        ),
        bottomNavigationBar:
            Consumer<MenuPageData>(builder: (context, ref, child) {
          List<int> bottomData = MenuPageViewModel().getItemsAndAmount(context);
          return bottomData[0] == 0
              ? GestureDetector(
                  onTap: () {
                    context.go("/menu/${Constants.id}");
                  },
                  child: Container(
                    color: Color(0xFF970040),
                    width: double.infinity,
                    height: 24 + 32,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Go to menu",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    )),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    context.go("/menu/${Constants.id}");
                  },
                  child: Container(
                    color: Color(0xFF970040),
                    width: double.infinity,
                    height: 24 + 32,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Go to menu and finish order",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    )),
                  ),
                );
        }),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            colors: [
                          Color(int.parse(restaurant!.color)),
                          Colors.white
                        ])),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        Container(
                          width: 100,
                          height: 50,
                          child: Image.network(restaurant!.logo),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(restaurant!.name,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )),
                        SizedBox(
                          height: 4,
                        ),
                        Text("${restaurant!.city}, ${restaurant!.state}",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            )),
                        SizedBox(
                          height: 4,
                        ),
                        Text("Your order will be ready in 00:01:23",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Consumer<MenuPageData>(
                      builder: (_, ref, __) {
                        final cartData =
                            StatusPageViewModel().getItemsAndAmount(context);
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your Order (${cartData[0]})",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  )),
                              ...(ref.order.entries.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: CartItem(
                                    item: ref.code_item[e.key]!,
                                    ref: ref,
                                  ),
                                );
                              }).toList())
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
