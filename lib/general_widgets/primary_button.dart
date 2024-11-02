import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Add this for custom fonts

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.width,
    this.height,
    this.text,
    required this.onTap,
  });

  final double? width;
  final double? height;
  final String? text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          width: width ?? 296,
          height: height ?? 52,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(34),
            boxShadow: const [
              BoxShadow(
                color: Color(0x662D2C83),
                offset: Offset(0, 4),
                blurRadius: 15,
              ),
            ],
          ),
          child: Center(
            child: Text(
              text ?? 'LOG IN',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 24 / 14,
                letterSpacing: 0.5,
                color: Colors.white,
              ),
              textAlign: TextAlign.center, // Text alignment
            ),
          ),
        ),
      ),
    );
  }
}
