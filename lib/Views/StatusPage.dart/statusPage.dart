// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/Models/orders.dart';
import 'package:dine/Storage/sharedPreference.dart';
import 'package:dine/ViewModels/CheckoutPageViewModel/checkoutPageViewModel.dart';
import 'package:dine/ViewModels/StatusPageViewModel/statusPageViewModel.dart';
// import 'package:dine/Views/CheckoutPage/widgets.dart';
import 'package:dine/Views/StatusPage.dart/statuscard.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

import '../../Utils/Constants/staticConstants.dart';
import '../../Models/restaurant.dart';
// import '../../ViewModels/MenuPageViewModel/menuPageViewModel.dart';

class Status extends StatelessWidget {
  Status({super.key});
  List<Orders> orders = [
    Orders(
      contactNo: "12312",
      customerName: "AYUSH",
      discount: .5,
      items: [],
      macAdd: "",
    )
  ];

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
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                context.go("/menu/${Constants.id}");
              },
              child: Container(
                  width: 396,
                  height: 53,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xff88001f)),
                  child: Center(
                      child: Text(
                    'Add More Items',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )))),
        ),
        // Consumer<MenuPageData>(builder: (context, ref, child) {
        //   List<int> bottomData = MenuPageViewModel().getItemsAndAmount(context);
        //   return bottomData[0] == 0
        // ? GestureDetector(
        //           onTap: () {
        //             context.go("/menu/${Constants.id}");
        //           },
        //           child: Container(
        //             color: const Color(0xFF970040),
        //             width: double.infinity,
        //             height: 24 + 32,
        //             child: const Center(
        //                 child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text("Go to menu",
        //                     style: TextStyle(
        //                       fontSize: 16,
        //                       color: Colors.white,
        //                       fontWeight: FontWeight.w500,
        //                     )),
        //               ],
        //             )),
        //           ),
        //         )
        //       : GestureDetector(
        //           onTap: () {
        //             context.go("/menu/${Constants.id}");
        //           },
        //           child: Container(
        //             color: const Color(0xFF970040),
        //             width: double.infinity,
        //             height: 24 + 32,
        //             child: const Center(
        //                 child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text("Go to menu and finish order",
        //                     style: TextStyle(
        //                       fontSize: 16,
        //                       color: Colors.white,
        //                       fontWeight: FontWeight.w500,
        //                     )),
        //               ],
        //             )),
        //           ),
        //         );
        // }),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            colors: [
                          Color(int.parse(restaurant!.color ?? "0xFFFFFF")),
                          Colors.white
                        ])),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Container(
                          width: 100,
                          height: 50,
                          child: Image.network(restaurant!.logo!),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(restaurant!.name!,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(
                          height: 4,
                        ),
                        Text("${restaurant!.city}, ${restaurant!.state}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            )),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text("Your order will be ready soon",
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("My Orders",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Consumer<MenuPageData>(
                      builder: (_, ref, __) {
                        final cartData =
                            StatusPageViewModel().getItemsAndAmount(context);
                        return Container(
                          padding: const EdgeInsets.all(8),

                          child: StreamBuilder(
                            stream: CheckoutViewModel()
                                .getOrderStream(Constants.id),
                            builder: (context, snapshot) {
                              print(snapshot.connectionState);
                              print(snapshot.data);
                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    ...List.generate(
                                      snapshot.data?.length ?? 0,
                                      (index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: StatusCard(
                                              order: snapshot.data?[index]),
                                        );
                                      },
                                    )
                                  ],
                                );

                                // ;

                                ListView.builder(
                                  itemCount: snapshot.data?.length ?? 0,
                                  itemBuilder: (_, index) {
                                    return StatusCard(
                                        order: snapshot.data?[index]);
                                  },
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                          // child: StatusCard()
                          //  SizedBox(
                          //   width: double.infinity,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       const SizedBox(),
                          //       ...(ref.order.entries.map((e) {
                          //         return Padding(
                          //           padding: const EdgeInsets.only(top: 16.0),
                          //           child: CartItem(
                          //             item: ref.code_item[e.key]!,
                          //             ref: ref,
                          //           ),
                          //         );
                          //       }).toList())
                          //     ],
                          //   ),
                          // ),
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
