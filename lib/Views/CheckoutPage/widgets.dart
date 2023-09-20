import 'package:dine/Shared/Widgets/cartButton.dart';
import 'package:dine/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Data/Repositories/MenuPage.dart';
import '../../Models/restaurantMenu.dart';

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
