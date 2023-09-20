import 'dart:convert';

import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/ViewModels/CheckoutPageViewModel/checkoutPageViewModel.dart';
import 'package:dine/Views/CheckoutPage/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Storage/sharedPreference.dart';
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
    final ref = Provider.of<MenuPageData>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                CheckoutViewModel().clearCart(context);
                setLocal(key: "order", value: jsonEncode(ref.order));
                context.go('/menu/${Constants.id}/status');
              },
              child: Container(
                  width: 396,
                  height: 53,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xff88001f)),
                  child: Center(
                      child: Text(
                    'Place Order',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )))),
        ),
        body: Card2());
  }
}
