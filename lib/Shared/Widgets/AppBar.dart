import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

PreferredSizeWidget customAppbar = AppBar(
  elevation: 0,
  backgroundColor: Colors.transparent,
  title: Row(
    children: [
      SvgPicture.asset('assets/logo.svg'),
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
    SvgPicture.asset('assets/timelapse.svg'),
    SizedBox(
      width: 24,
    ),
  ],
);
