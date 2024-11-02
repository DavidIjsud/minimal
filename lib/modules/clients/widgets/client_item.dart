import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal/core/app_colors.dart';

import '../../../core/images.dart';

class ClientItem extends StatelessWidget {
  const ClientItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 326,
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white, // Ensures opacity is zero
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.black),
          right: BorderSide(width: 1.0, color: Colors.black),
          bottom: BorderSide(width: 1.0, color: Colors.black),
          left: BorderSide(width: 1.0, color: Colors.black),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.transparent, // This ensures there's no background
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(37.24),
                  topRight: Radius.circular(37.24),
                  bottomLeft: Radius.circular(37.24),
                  bottomRight: Radius.circular(37.24),
                ),
                image: DecorationImage(
                  image: AssetImage(Images
                      .professionalPicture), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10), // Adjust spacing between avatar and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'JJane Cooper',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height:
                        18.2 / 14, // line-height is a ratio of the font-size
                    letterSpacing: 0.25,
                    textBaseline: TextBaseline.alphabetic,
                    color: AppColors.minimalBlack2,
                  ),
                ),
                Text(
                  'davidijsud@gmail.com',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height:
                        15.6 / 12, // line-height is a ratio of the font-size
                    letterSpacing: 0.25,
                    color: AppColors.minimalGray2, // hex color
                  ),
                )
              ],
            ),
            Expanded(child: Container()),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }
}
