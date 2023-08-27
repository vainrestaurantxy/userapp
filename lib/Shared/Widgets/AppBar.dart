import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../Constants/staticConstants.dart';
import '../../Data/Repositories/MenuPage.dart';

createAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Row(
      children: [
        SvgPicture.asset(
          'assets/logo.svg',
          theme: SvgTheme(currentColor: Colors.black),
        ),
        SizedBox(
          width: 5,
        ),
        Text("DINE",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ))
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
          child: SvgPicture.asset('assets/timelapse.svg')),
      SizedBox(
        width: 24,
      ),
    ],
  );
}
