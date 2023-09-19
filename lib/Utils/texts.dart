import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget giveText(String text, double size, int weight) {
  if (weight == 400) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: Colors.black, fontSize: size, fontWeight: FontWeight.w400),
    );
  } else if (weight == 500) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: Colors.black, fontSize: size, fontWeight: FontWeight.w500),
    );
  } else if (weight == 600) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: Colors.black, fontSize: size, fontWeight: FontWeight.w600),
    );
  }
  return Text(
    text,
    style: GoogleFonts.poppins(
        color: Colors.black, fontSize: size, fontWeight: FontWeight.bold),
  );
}
