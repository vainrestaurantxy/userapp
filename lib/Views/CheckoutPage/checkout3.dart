import 'dart:convert';
import 'dart:developer';

import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/Storage/sharedPreference.dart';
import 'package:dine/Views/CheckoutPage/widgets.dart';
import 'package:dine/Views/MenuPage/menuPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Utils/Constants/staticConstants.dart';
import '../../ViewModels/CheckoutPageViewModel/checkoutPageViewModel.dart';

class ConfirmOrder extends StatelessWidget {
  ConfirmOrder({super.key});
  int taxPercent = 14;

  @override
  Widget build(BuildContext context) {
    final ref = Provider.of<MenuPageData>(context, listen: false);
    CheckoutViewModel().getCart(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("CHECKOUT",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
            onPressed: () {
              context.go("/menu/${Constants.id}/checkout/checkout2/checkout3");
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<MenuPageData>(builder: (context, _, __) {
          if (_.cart.isEmpty) {
            return const SizedBox(
              width: double.infinity,
              height: 100,
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    "Are you sure you want to place the following order?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                ...(ref.cart.entries.map((e) {
                  // log(e.key.toString() + ":" + e.value.toString());
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    //   child: CartItem(
                    //   quantity: ref.cart,
                    //   image:
                    //       ref.code_item[ref.cart.keys.toList()[index]]?.image ??
                    //           "",
                    //   itemButton: false,
                    //   name: ref.code_item[ref.cart.keys.toList()[index]]?.name ??
                    //       "",
                    //   menu: ref.code_item[ref.cart.keys.toList()[index]]!,
                    // ),
                    child: Container(),
                  );
                }).toList()),
                SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            "MRP: INR ${CheckoutViewModel().getItemsAndAmount(context)[1]}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                        Text("Tax: ${taxPercent}%",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                        Text(
                            "Total INR: ${CheckoutViewModel().getItemsAndAmount(context)[1] + (CheckoutViewModel().getItemsAndAmount(context)[1] * (taxPercent / 100))}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    )),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF970040),
                    ),
                    onPressed: () {
                      CheckoutViewModel().clearCart(context);
                      setLocal(key: "order", value: jsonEncode(ref.order));
                      context.go('/menu/${Constants.id}/status');
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        width: double.infinity,
                        height: 48,
                        child: const Center(
                            child: Text("Confirm Order",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ))))),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.black)),
                    onPressed: () {
                      context.pop();
                    },
                    child: Container(
                        width: double.infinity,
                        height: 48,
                        child: const Center(
                            child: Text("Go Back",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                )))))
              ],
            ),
          );
        }),
      ),
    );
  }
}
