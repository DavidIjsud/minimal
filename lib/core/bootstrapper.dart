import 'dart:async';
import 'dart:developer';

import 'package:minimal/modules/login/viewmodels/login_view_model.dart';

import 'flavor.dart';

enum InitializationStatus {
  disposed,
  error,
  initialized,
  initializing,
  unsafeDevice,
}

abstract class Bootstrapper {
  factory Bootstrapper.fromFlavor(Flavor flavor) {
    Bootstrapper result;
    switch (flavor) {
      case Flavor.dev:
        result = _DevBootstrapper();
        break;
      case Flavor.prod:
        result = _ProdBootstrapper();
        break;
    }

    return result;
  }

  LoginViewModel get loginViewModel;

  Stream<InitializationStatus> get initializationStream;

  Future<void> bootstrap();
  void dispose();
}

class _DefaultBootstrapper implements Bootstrapper {
  _DefaultBootstrapper(Flavor flavor) : _flavor = flavor;

  final Flavor _flavor;
  InitializationStatus _initializationStatus =
      InitializationStatus.initializing;
  final StreamController<InitializationStatus> _initializationStreamController =
      StreamController<InitializationStatus>.broadcast();

  late LoginViewModel _loginViewModel;

  @override
  LoginViewModel get loginViewModel => _loginViewModel;

  Future<void> _initializeViewModels() async {
    _loginViewModel = LoginViewModel();
  }

  @override
  Future<void> bootstrap() async {
    if (_initializationStatus != InitializationStatus.initialized) {
      try {
        log('Starting bootstrap process...');
        await _initializeViewModels();
        _initializationStatus = InitializationStatus.initialized;
        log('Bootstrap process completed successfully.');
      } catch (e) {
        _initializationStatus = InitializationStatus.error;
        log('Error during bootstrap process: $e');
      }

      _initializationStreamController.add(_initializationStatus);
    }
  }

  @override
  void dispose() {}

  @override
  Stream<InitializationStatus> get initializationStream =>
      _initializationStreamController.stream;
}

class _DevBootstrapper extends _DefaultBootstrapper {
  _DevBootstrapper() : super(Flavor.dev);
}

class _ProdBootstrapper extends _DefaultBootstrapper {
  _ProdBootstrapper() : super(Flavor.dev);
}
