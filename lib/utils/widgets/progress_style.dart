import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget appProgress({
  required String time,
  required double percent,
  Color progressColor = const Color(0xFFE63946),
  Color backgroundColor = const Color(0xFFF28482),
  double radius = 125,
  double lineWidth = 12,
}) {
  return CircularPercentIndicator(
    radius: radius,
    lineWidth: lineWidth,
    percent: percent,
    center: Text(
      time,
      style: GoogleFonts.poppins(
        fontSize: 55,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
    progressColor: progressColor,
    backgroundColor: backgroundColor,
    circularStrokeCap: CircularStrokeCap.round,
  );
}
