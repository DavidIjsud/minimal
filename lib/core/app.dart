import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modules/login/pages/login_page.dart';
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
    widget.bootstrapper.bootstrap();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<InitializationStatus>(
      initialData: InitializationStatus.initializing,
      stream: widget.bootstrapper.initializationStream,
      builder: (_, snapshot) {
        Widget result;
        switch (snapshot.data) {
          case InitializationStatus.initialized:
            result = MultiProvider(
              providers: const [],
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
        return MaterialApp(
          home: result,
        );
      },
    );
  }
}
