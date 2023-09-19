import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Utils/Constants/staticConstants.dart';
import '../../Data/Repositories/MenuPage.dart';

createAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Row(
      children: [
        SvgPicture.asset(
          'assets/logo.svg',
          theme: const SvgTheme(currentColor: Colors.black),
        ),
        const SizedBox(
          width: 5,
        ),
        Text("DINE",
            style: GoogleFonts.poppins(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600))
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
          child: Image.asset(
            'assets/Icon.png',
            height: 10,
          )),
      // const SizedBox(
      //   width: 24,
      // ),
    ],
  );
}
