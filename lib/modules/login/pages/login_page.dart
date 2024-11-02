import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal/core/images.dart';
import 'package:minimal/core/navigation.dart';
import 'package:minimal/general_widgets/primary_button.dart';
import 'package:minimal/general_widgets/primary_textfield.dart';
import 'package:minimal/modules/clients/pages/client_page.dart';

class LoginPagePage extends StatefulWidget {
  const LoginPagePage({super.key});

  @override
  State<LoginPagePage> createState() => _LoginPagePageState();
}

class _LoginPagePageState extends State<LoginPagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              right: 0.0,
              child: Image.asset(
                Images.backgroundLoginUpRight,
                width: 300.0,
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.15,
              child: Image.asset(Images.backgroundLoginCenterLeft),
            ),
            Positioned(
              bottom: 0.0,
              child: Image.asset(Images.backgroundLoginBottomCenter),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.minimalLogo,
                    width: 300.0,
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  const Text(
                    'LOG IN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 24 / 12, // line-height divided by font-size
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  const PrimaryTextfield(),
                  const SizedBox(
                    height: 7.0,
                  ),
                  const PrimaryTextfield(),
                  const SizedBox(
                    height: 40.0,
                  ),
                  PrimaryButton(
                    onTap: () {
                      NavigatorApp.push(context, const ClientPage());
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
