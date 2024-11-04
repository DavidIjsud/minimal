import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minimal/modules/clients/viewmodels/clients_viewmodel.dart';
import 'package:provider/provider.dart';

import '../modules/login/pages/login_page.dart';
import '../modules/login/viewmodels/login_view_model.dart';
import 'bootstrapper.dart';

class App extends StatefulWidget {
  App({
    required this.bootstrapper,
    Key? key,
  }) : super(key: key);

  final Bootstrapper bootstrapper;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.bootstrapper.bootstrap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<InitializationStatus>(
      initialData: InitializationStatus.initializing,
      stream: widget.bootstrapper.initializationStream,
      builder: (_, snapshot) {
        Widget result;
        //log("Result of bootstraping ${snapshot.data} and loginViewModel is ${widget.bootstrapper.loginViewModel.state?.isLoadingLogin}");
        switch (snapshot.data) {
          case InitializationStatus.initialized:
            result = MultiProvider(
              providers: [
                Provider(create: (_) => widget.bootstrapper.imagesPicker),
                ChangeNotifierProvider<LoginViewModel>(
                  create: (_) => widget.bootstrapper.loginViewModel,
                ),
                ChangeNotifierProvider<ClientsViewModel>(
                  create: (_) => widget.bootstrapper.clientsViewModel,
                ),
              ],
              child: const MaterialApp(
                home: LoginPagePage(),
              ),
            );
            break;
          case InitializationStatus.error:
            result = const SizedBox.shrink();
            break;
          case InitializationStatus.initializing:
            result = const SizedBox.shrink();
            break;
          case InitializationStatus.unsafeDevice:
            result = const SizedBox.shrink();
            break;
          case InitializationStatus.disposed:
            result = const SizedBox.shrink();
            break;
          case null:
            result = const SizedBox.shrink();
        }
        return result;
      },
    );
  }
}
