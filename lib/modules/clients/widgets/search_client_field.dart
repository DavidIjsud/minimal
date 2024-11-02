import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchClientField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 217, // Fixed width
      height: 36, // Fixed height
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(68), // Border radius
          topRight: Radius.circular(68),
          bottomRight: Radius.circular(68),
          bottomLeft: Radius.circular(68),
        ),
        border: Border.all(
            color: const Color(0x1F1D2B9C), width: 1), // Border color
        color: const Color(0xFFFEFEFE), // Background color
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.all(0), // No gap
            child: SizedBox(
              width: 11.83, // Icon width
              height: 11.83, // Icon height
              child: Icon(
                Icons.search,
                color: Color(0xFF616060), // Icon color
              ),
            ),
          ),
          hintText: 'Search...',
          hintStyle: GoogleFonts.dmSans(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            height: 16.93 / 13, // line-height as a ratio
            color: const Color(0x9E000000), // Hint text color
          ),
          contentPadding: const EdgeInsets.fromLTRB(15, 12, 15, 12), // Padding
          border: InputBorder.none, // No border
        ),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black, // Text color
        ),
      ),
    );
  }
}
