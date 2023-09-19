import 'package:dine/Shared/Widgets/cartButton.dart';
import 'package:flutter/material.dart';

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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 4,
                  ),
                  Text("INR ${item.price}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              button
                  ? getAddButton(code: item.code, ref: ref)
                  : const SizedBox()
            ],
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width - 16 * 2,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
