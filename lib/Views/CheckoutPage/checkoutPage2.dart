import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/ViewModels/CheckoutPageViewModel/checkoutPageViewModel.dart';
import 'package:dine/Views/CheckoutPage/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../Utils/Constants/staticConstants.dart';
import '../../Utils/texts.dart';

class CheckoutCartPage extends StatefulWidget {
  const CheckoutCartPage({super.key});

  @override
  State<CheckoutCartPage> createState() => _CheckoutCartPageState();
}

class _CheckoutCartPageState extends State<CheckoutCartPage> {
  @override
  Widget build(BuildContext context) {
    CheckoutViewModel().getCart(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          context.go("/menu/${Constants.id}/checkout/checkout2/checkout3");
        },
        child: Container(
          color: const Color(0xFF970040),
          width: double.infinity,
          height: 24 + 32,
          child: const Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Place Order",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: giveText('Cart', 20, 600)),
              Align(
                  alignment: Alignment.centerLeft,
                  child:
                      giveText('Verify order details & place order', 14, 400)),
              const SizedBox(
                height: 35,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: const [
                      BoxShadow(
                          spreadRadius: 2,
                          color: Color.fromARGB(124, 0, 0, 0),
                          blurRadius: 2)
                    ]),
                child: Consumer<MenuPageData>(
                  builder: (_, ref, __) {
                    List<int> cartData =
                        CheckoutViewModel().getItemsAndAmount(context);
                    if (cartData[0] == 0) {
                      return const SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Your Cart (${cartData[0]})",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              )),
                          ...(ref.cart.entries.map((e) {
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
