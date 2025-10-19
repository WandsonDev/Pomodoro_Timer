import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appButton({
  required String text,
  required VoidCallback onPressed,
  double width = 280,
  double height = 40,
  double borderRadius = 15,
  Color backgroundColor = const Color(0xFFE63946),
  Color foregroundColor = Colors.white, 
  
  Color? shadowColor, 
  double elevation = 2,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shadowColor: shadowColor ?? backgroundColor.withOpacity(0.5),
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
    ),
  );
}
