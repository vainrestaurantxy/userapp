import 'package:dine/ViewModels/CheckoutPageViewModel/checkoutPageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../Constants/staticConstants.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
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
          context.go("/menu/${Constants.id}/checkout/checkout2");
        },
        child: Container(
          color: Color(0xFF970040),
          width: double.infinity,
          height: 24 + 32,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Add details to proceed",
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
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                    width: (MediaQuery.of(context).size.width / 428) * 259,
                    child: TextFormField(
                      onChanged: (v) {
                        Constants.name = v;
                      },
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
              onChanged: (v) {
                Constants.phone = v;
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  label: Text("Mobile No."),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF8C8C8C))),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF8C8C8C)))),
            )
          ],
        ),
      ),
    );
  }
}
