import 'dart:convert';
import 'dart:developer';

import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/Storage/sharedPreference.dart';
import 'package:dine/Views/CheckoutPage/widgets.dart';
import 'package:dine/Views/MenuPage/menuPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../Constants/staticConstants.dart';
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
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text("CHECKOUT",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<MenuPageData>(
          builder: (context,_,__) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Are you sure you want to place the following order?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                ...(ref.cart.entries.map((e) {
                  log(e.key.toString() + ":" + e.value.toString());
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CartItem(
                      button: false,
                      item: ref.code_item[e.key]!,
                      ref: ref,
                    ),
                  );
                }).toList()),
                SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            "MRP: INR ${CheckoutViewModel().getItemsAndAmount(context)[1]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                        Text("Tax: ${taxPercent}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                        Text(
                            "Total INR: ${CheckoutViewModel().getItemsAndAmount(context)[1] + (CheckoutViewModel().getItemsAndAmount(context)[1] * (taxPercent / 100))}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    )),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF970040),
                    ),
                    onPressed: () {
                      CheckoutViewModel().clearCart(context);
                      setLocal(key: "order", value: jsonEncode(ref.order));
                      context.go('/menu/${Constants.id}/status');
                    },
                    child: Container(
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(12)),
                        width: double.infinity,
                        height: 48,
                        child: Center(
                            child: Text("Confirm Order",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ))))),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.black)),
                    onPressed: () {
                      context.pop();
                    },
                    child: Container(
                        width: double.infinity,
                        height: 48,
                        child: Center(
                            child: Text("Go Back",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                )))))
              ],
            );
          }
        ),
      ),
    );
  }
}
