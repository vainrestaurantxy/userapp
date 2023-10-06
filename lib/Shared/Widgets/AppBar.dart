import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Utils/Constants/staticConstants.dart';
import '../../Data/Repositories/MenuPage.dart';

createAppBar(BuildContext context) {
  final repo = Provider.of<MenuPageData>(context, listen: false);
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          child: Image.asset(
            'assets/Logo Feast.png',
          ),
        ),
        Text("Feast",
            style: GoogleFonts.poppins(
                fontSize: 23, color: Colors.black, fontWeight: FontWeight.w600))
      ],
    ),
    actions: [
      GestureDetector(
          onTap: () {
            final prov = Provider.of<MenuPageData>(context, listen: false);
            if (prov.order.isNotEmpty) {
              try {
                context.go("/menu/${Constants.id}/status");
              } catch (e) {
                log(e.toString());
              }
            }
          },
          child: repo.myOrders
              ? GestureDetector(
                  onTap: () {
                    context.go('/menu/${Constants.id}/status');
                  },
                  child: Image.asset(
                    'assets/restaurantIcon.png',
                    height: 10,
                  ),
                )
              : Image.asset(
                  'assets/Icon.png',
                  height: 10,
                )),
      // const SizedBox(
      //   width: 24,
      // ),
    ],
  );
}
