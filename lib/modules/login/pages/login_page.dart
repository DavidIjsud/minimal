import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal/core/images.dart';
import 'package:minimal/core/navigation.dart';
import 'package:minimal/general_widgets/primary_button.dart';
import 'package:minimal/general_widgets/primary_textfield.dart';
import 'package:minimal/modules/clients/pages/client_page.dart';
import 'package:provider/provider.dart';

import '../viewmodels/login_view_model.dart';

class LoginPagePage extends StatefulWidget {
  const LoginPagePage({super.key});

  @override
  State<LoginPagePage> createState() => _LoginPagePageState();
}

class _LoginPagePageState extends State<LoginPagePage> {
  late final LoginViewModel _loginViewModel;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _loginViewModel = context.read<LoginViewModel>();
    _loginViewModel.initViewModel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listenViewModelLogin();
    });
  }

  void _listenViewModelLogin() {
    _loginViewModel.addListener(() {
      log('Login status: ${_loginViewModel.state?.isLoggedInSucces}');
      if (_loginViewModel.state?.isLoggedInSucces == true) {
        NavigatorApp.pushReplacement(context, const ClientPage());
      }
    });
  }

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
                  PrimaryTextfield(
                    controller: _emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Consumer<LoginViewModel>(
                      builder: (_, viewModelLogin, Widget? w) {
                    return PrimaryTextfield(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Password',
                      obscureText: viewModelLogin.state?.hidePassword ?? true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          viewModelLogin.toggleHidePassword();
                        },
                        padding: const EdgeInsets.only(bottom: 0.0),
                        icon: const Icon(
                          Icons.remove_red_eye,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Consumer<LoginViewModel>(
                      builder: (_, viewModelLogin, Widget? w) {
                    return PrimaryButton(
                      isLoading: viewModelLogin.state?.isLoadingLogin ?? false,
                      onTap: viewModelLogin.state?.isLoadingLogin == true
                          ? null
                          : () {
                              _loginViewModel.login(
                                _emailController.text,
                                _passwordController.text,
                              );
                            },
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
