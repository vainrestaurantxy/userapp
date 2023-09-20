import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/ViewModels/CheckoutPageViewModel/checkoutPageViewModel.dart';
import 'package:dine/Views/CheckoutPage/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
<<<<<<< Updated upstream
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
                    // if (cartData[0] == 0) {
                    //   return const SizedBox(
                    //     width: double.infinity,
                    //     height: 100,
                    //     child: Center(child: CircularProgressIndicator()),
                    //   );
                    // }
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
=======
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: giveText('Cart', 20, 600)),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: giveText(
                          'Verify order details & place order', 14, 400)),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
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
>>>>>>> Stashed changes
                            );
                          }
                          return SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: 'Table Number: ',
                                                    children: [
                                                      TextSpan(
                                                          text: Constants
                                                              .tableNo
                                                              .toString(),
                                                          style: GoogleFonts.poppins(
                                                              color: const Color(
                                                                  0xff53389e),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                    ],
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ]),
                                            ),
                                            const SizedBox(
                                              width: 146,
                                            ),
                                            const Icon(Icons.edit)
                                          ],
                                        ),
                                        Constants.name == ''
                                            ? const SizedBox()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  RichText(
                                                    textAlign: TextAlign.left,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                              'Customer Name: ',
                                                          children: [
                                                            TextSpan(
                                                                text: Constants
                                                                    .name,
                                                                style: GoogleFonts.poppins(
                                                                    color: const Color(
                                                                        0xff53389e),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ],
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                    ]),
                                                  ),
                                                  const SizedBox(
                                                    width: 146,
                                                  )
                                                ],
                                              ),
                                        Constants.phone == ''
                                            ? const SizedBox()
                                            : Row(
                                                children: [
                                                  RichText(
                                                    textAlign: TextAlign.left,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                              'Customer Number: ',
                                                          children: [
                                                            TextSpan(
                                                                text: Constants
                                                                    .phone,
                                                                style: GoogleFonts.poppins(
                                                                    color: const Color(
                                                                        0xff53389e),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ],
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                    ]),
                                                  ),
                                                  const SizedBox(
                                                    width: 146,
                                                  )
                                                ],
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                                for (var entry in ref.cart.entries)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: CartItem(
                                      item: ref.code_item[entry.key]!,
                                      ref: ref,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {
                    context.go(
                        "/menu/${Constants.id}/checkout/checkout2/checkout3");
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
          ),
        ],
      ),
    );
  }
}
