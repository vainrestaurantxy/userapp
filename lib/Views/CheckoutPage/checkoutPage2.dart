import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/ViewModels/CheckoutPageViewModel/checkoutPageViewModel.dart';
import 'package:dine/Views/CheckoutPage/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../Constants/staticConstants.dart';

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
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text("CHECKOUT",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            )),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          context.go("/menu/${Constants.id}/checkout/checkout2/checkout3");
        },
        child: Container(
          color: Color(0xFF970040),
          width: double.infinity,
          height: 24 + 32,
          child: Center(
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
              Row(
                children: [
                  SizedBox(
                      width: (MediaQuery.of(context).size.width / 428) * 259,
                      child: TextFormField(
                        readOnly: true,
                        initialValue: Constants.name,
                        decoration: InputDecoration(
                            label: Text("Name"),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF8C8C8C))),
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF8C8C8C)))),
                      )),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      // width: (MediaQuery.of(context).size.width / 428) * 109,
                      child: TextFormField(
                    readOnly: true,
                    initialValue: Constants.tableNo.toString(),
                    decoration: InputDecoration(
                        label: Text("Table No."),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF8C8C8C))),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF8C8C8C)))),
                  )),
                ],
              ),
              TextFormField(
                readOnly: true,
                initialValue: Constants.phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    label: Text("Mobile No."),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF8C8C8C))),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF8C8C8C)))),
              ),
              SizedBox(
                height: 24,
              ),
              Consumer<MenuPageData>(
                builder: (_, ref, __) {
                  List<int> cartData =
                      CheckoutViewModel().getItemsAndAmount(context);
                  if(cartData[0]==0){
                    return SizedBox(width: double.infinity,height: 100,child: CircularProgressIndicator(),);
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Your Cart (${cartData[0]})",
                            style: TextStyle(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
