import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine/Models/orders.dart';
import 'package:dine/Shared/Widgets/cartButton.dart';
import 'package:dine/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart' as prov;

import '../../Data/Repositories/MenuPage.dart';
import '../../Models/restaurantMenu.dart';
import '../../Utils/Constants/staticConstants.dart';
import '../../ViewModels/CheckoutPageViewModel/checkoutPageViewModel.dart';
import '../MenuPage/menuPage.dart';

class CartItem extends StatelessWidget {
  CartItem(
      {super.key,
      this.name,
      this.price,
      this.image,
      this.quantity,
      this.menu,
      this.itemButton = true});
  String? name;
  int? price;
  bool itemButton;
  Map<String, dynamic>? quantity;
  String? image;
  RestaurantMenu? menu;
  @override
  Widget build(BuildContext context) {
    print(quantity);
    return SizedBox(
      width: double.infinity,
      // height: 100,
      child: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Restaurants")
                .doc(Constants.id)
                .collection("Orders")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: [
                  SizedBox(
                    // height: 43,
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 43,
                              height: 43,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFD9D9D9),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Image.network(
                                image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 253 / 2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 297 / 2,
                                    child: Text(
                                      '${name}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        'AED ${price}  ',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      SizedBox(
                                        child: quantity![name] == null ||
                                                quantity![name] == 0
                                            ? const SizedBox()
                                            : Text(
                                                'Qty: ${quantity![name]} ',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          child: itemButton
                              ? prov.Consumer<MenuPageData>(
                                  builder: (_, ref, __) {
                                    return getAddButton(name: name!, ref: ref);
                                  },
                                )
                              : const SizedBox(),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  const Card2({super.key});

  @override
  Widget build(BuildContext context) {
    // List<Orders> suggested = [];
    final repo = prov.Provider.of<MenuPageData>(context, listen: false);
    // // repo.getSuggestions();
    // print("Cart:");
    // print(repo.cart);
    CheckoutViewModel().getSuggestions(
      context,
    );

    return Padding(
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
                child: giveText('Verify order details & place order', 14, 400)),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 0, 16),
              child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: const [
                        BoxShadow(
                            spreadRadius: 2,
                            color: Color.fromARGB(124, 0, 0, 0),
                            blurRadius: 8)
                      ]),
                  child: const CardTexts()),
            ),
            const SizedBox(
              height: 16,
            ),
            prov.Consumer<MenuPageData>(
              builder: (context, ref, child) {
                List<String>? suggestionList = ref.sugg;
                return suggestionList!.length>0?
                Column(
                  children: [
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: giveText('Suggested', 16, 500)),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Builder(
                        builder: (context) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: suggestionList?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CartItem(
                                  image:
                                      ref.code_item[suggestionList[index]]?.image ??
                                          "",
                                  name:
                                      ref.code_item[suggestionList[index]]?.name ??
                                          "",
                                  price:
                                      ref.code_item[suggestionList[index]]?.price ??
                                          0,
                                  itemButton: true,
                                  quantity: ref.cart,
                                  menu: ref.code_item[suggestionList[index]],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ):SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}

class CardTexts extends StatelessWidget {
  const CardTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return prov.Consumer<MenuPageData>(
      builder: (_, ref, __) {
        List<int> cartData = CheckoutViewModel().getItemsAndAmount(context);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Table Number: ',
                          children: [
                            TextSpan(
                                text: Constants.tableNo.toString(),
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff53389e),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ],
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ],
              ),
              Constants.name == ''
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Customer Name: ',
                                children: [
                                  TextSpan(
                                      text: Constants.name,
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xff53389e),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600)),
                                ],
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400)),
                          ]),
                        ),
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
                                text: 'Customer Number: ',
                                children: [
                                  TextSpan(
                                      text: Constants.phone,
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xff53389e),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600)),
                                ],
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400)),
                          ]),
                        ),
                      ],
                    ),
              Column(
                children: List.generate(ref.cart.keys.length, (index) {
                  // print("Cart : ");
                  // print(ref.cart.keys.length);
                  // print(ref.code_item[ref.cart.keys.toList()[index]]?.name ??
                  // "NULL");
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CartItem(
                      price:
                          ref.code_item[ref.cart.keys.toList()[index]]?.price ??
                              0,
                      quantity: ref.cart,
                      image:
                          ref.code_item[ref.cart.keys.toList()[index]]?.image ??
                              "",
                      itemButton: true,
                      name:
                          ref.code_item[ref.cart.keys.toList()[index]]?.name ??
                              "",
                      menu: ref.code_item[ref.cart.keys.toList()[index]]!,
                    ),
                  );
                }),
              ),
              const Divider(),
              SizedBox(
                width: double.infinity,
                child: (ref.cart.isEmpty)
                    ? const SizedBox()
                    : Container(
                        width: 364,
                        height: 88,
                        padding: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Order Total:',
                                        style: TextStyle(
                                          color: Color(0xFF3B3F5C),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' ${ref.getTotal()} AED\n',
                                        style: const TextStyle(
                                          color: Color(0xFF3B3F5C),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: 'Tax (5%):',
                                        style: TextStyle(
                                          color: Color(0xFF3B3F5C),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' ${(ref.getTotal() * 0.05).toStringAsFixed(2)} AED\n',
                                        style: const TextStyle(
                                          color: Color(0xFF3B3F5C),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: 'Discount:',
                                        style: TextStyle(
                                          color: Color(0xFF3B3F5C),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' ${ref.getDiscount()} AED\n',
                                        style: const TextStyle(
                                          color: Color(0xFF3B3F5C),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: 'Total: ',
                                        style: TextStyle(
                                          color: Color(0xFF3B3F5C),
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${((ref.getTotal() + ref.getTotal() * 0.05) - ref.getDiscount()).toStringAsFixed(2)} AED',
                                        style: const TextStyle(
                                          color: Color(0xFF53389E),
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
