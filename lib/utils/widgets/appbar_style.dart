import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar buildAppBar({
  required String title,
  Color backgroundColor = const Color(0xFFE63946),
  Color titleColor = Colors.white,
  bool centerTitle = true,
  double elevation = 2,
  List<Widget>? actions,
  Widget? leading,
}) {
  return AppBar(
    title: Text(
      title,
      style: GoogleFonts.poppins(
        color: titleColor,
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: backgroundColor,
    centerTitle: centerTitle,
    elevation: elevation,
    leading: leading,
    actions: actions,
  );
}
