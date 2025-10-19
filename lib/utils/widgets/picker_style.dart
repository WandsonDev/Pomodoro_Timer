// Função de Dialog que permite escolher o Timer

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showTimePickerDialog({
  required BuildContext context,
  required int initialMin,
  required int initialSec,
  required Function(int, int) onConfirm,
}) async {
  int tempMin = initialMin;
  int tempSec = initialSec;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Color(0xFFF1FAEE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Escolha o tempo",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Color(0xFF333333)),
        ),
        content: SizedBox(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: tempMin,
                  ),
                  itemExtent: 32,
                  onSelectedItemChanged: (value) {
                    tempMin = value;
                  },
                  children: List.generate(
                    121,
                    (index) => Center(
                      child: Text(
                        index.toString().padLeft(2, '0'),
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  ":",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
              ),

              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: tempSec,
                  ),
                  itemExtent: 32,
                  onSelectedItemChanged: (value) {
                    tempSec = value;
                  },
                  children: List.generate(
                    60,
                    (index) => Center(
                      child: Text(
                        index.toString().padLeft(2, '0'),
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancelar",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Color(0xFFF28482)),
            ),
          ),
          TextButton(
            onPressed: () {
              onConfirm(tempMin, tempSec);
              Navigator.pop(context);
            },
            child: Text(
              "Confirmar",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Color(0xFFE63946)),
            ),
          ),
        ],
      );
    },
  );
}
