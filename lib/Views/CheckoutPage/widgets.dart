import 'package:dine/Shared/Widgets/cartButton.dart';
import 'package:dine/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Data/Repositories/MenuPage.dart';
import '../../Models/restaurantMenu.dart';
import '../../Utils/Constants/staticConstants.dart';
import '../../ViewModels/CheckoutPageViewModel/checkoutPageViewModel.dart';

class CartItem extends StatelessWidget {
  CartItem(
      {super.key, required this.item, required this.ref, this.button = true});
  RestaurantMenu item;
  MenuPageData ref;
  bool button = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Image.network(
                    item.image,
                    height: 43,
                    width: 43,
                    fit: BoxFit.fill,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  giveText(item.name, 14, 400),
                  const SizedBox(
                    height: 4,
                  ),
                  giveText('INR ${item.price}', 12, 400),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              SizedBox(
                width: 16,
              ),
              button
                  ? getAddButton(code: item.code, ref: ref)
                  : const SizedBox()
            ],
          ),
        ],
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  const Card2({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      child: CardTexts()),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardTexts extends StatelessWidget {
  const CardTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuPageData>(
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
                  const Icon(
                    Icons.edit,
                    size: 20,
                  )
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
              for (var entry in ref.cart.entries)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CartItem(
                    item: ref.code_item[entry.key]!,
                    ref: ref,
                  ),
                ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
              )
            ],
          ),
        );
      },
    );
  }
}
