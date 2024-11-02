import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal/general_widgets/primary_button.dart';
import 'package:minimal/modules/clients/widgets/client_item.dart';

import '../../../core/images.dart';
import '../widgets/search_client_field.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              left: 0.0,
              child: Image.asset(
                Images.backgroundClientsTopLeft,
              ),
            ),
            Positioned(
              right: 0.0,
              bottom: MediaQuery.of(context).size.height * 0.25,
              child: Image.asset(
                Images.backgroundClientsCenterRight,
                width: 350.0,
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 150,
              child: Image.asset(
                Images.backgroundLoginBottomCenter,
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 5.0,
              child: Image.asset(
                Images.backgroundClientsBottomRight,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Image.asset(
                      Images.minimalLogo,
                      width: 150.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'CLIENTS',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.dmSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 20 / 20, // line-height as a ratio
                            letterSpacing: 1,
                            color: const Color(
                                0xFF0434545) // Te// Background color
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SearchClientField(),
                        PrimaryButton(
                          onTap: () {},
                          width: 93,
                          height: 29,
                          text: 'ADD NEW',
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    const ClientItem(),
                    Expanded(child: Container()),
                    PrimaryButton(
                      onTap: () {},
                      text: 'LOAD MORE',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
