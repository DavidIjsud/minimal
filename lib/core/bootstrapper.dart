import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minimal/core/endpoints.dart';
import 'package:minimal/modules/clients/repositories/client_repository.dart';
import 'package:minimal/modules/clients/viewmodels/clients_viewmodel.dart';
import 'package:minimal/modules/login/repositories/login_repository.impl.dart';
import 'package:minimal/modules/login/viewmodels/login_view_model.dart';
import 'package:minimal/services/storages/images_picker.dart';
import 'package:minimal/storage/secure_storage.dart';
import 'package:minimal/storage/secure_storage.impl.dart';

import '../modules/clients/repositories/client_repository.impl.dart';
import '../modules/login/repositories/login_repository.dart';
import '../services/storages/images_picker.impl.dart';
import 'flavor.dart';
import '../services/network/network_client.dart';

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
  ClientsViewModel get clientsViewModel;
  ImagesPicker get imagesPicker;

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
  //view Models
  late LoginViewModel _loginViewModel;
  late ClientsViewModel _clientViewModel;
  //repository
  late LoginRepository _loginRepository;
  late ClientRepository _clientRepository;
  //extra services
  late NetworkClient _networkClient;
  late SecureStorage _secureStorage;
  late Endpoints _endpoints;
  late ImagesPicker _imagesPicker;

  Future<void> _initializeViewModels() async {
    _loginViewModel = LoginViewModel(
      loginRepository: _loginRepository,
      secureStorage: _secureStorage,
    );

    _clientViewModel = ClientsViewModel(
      clientRepository: _clientRepository,
      pickerImage: _imagesPicker,
    );
  }

  Future<void> _initializeRepositories() async {
    _loginRepository = LoginRepositoryImpl(
        networkClient: _networkClient, endpoints: _endpoints);
    _clientRepository = ClientRepositoryImpl(
      networkClient: _networkClient,
      endpoints: _endpoints,
    );
  }

  Future<void> _loadEndPointsFromRootBundle() async {
    final configJson = await rootBundle.loadString(_flavor.configFile);
    _endpoints = Endpoints.fromJson(jsonDecode(configJson));
  }

  Future<void> _initExtraServices() async {
    _secureStorage = SecureStorageImpl();
    _networkClient = NetworkClient(secureStorage: _secureStorage);
    await _loadEndPointsFromRootBundle();
    _imagesPicker = ImagesPickerImpl(
      picker: ImagePicker(),
    );
  }

  @override
  Future<void> bootstrap() async {
    if (_initializationStatus != InitializationStatus.initialized) {
      try {
        log('Starting bootstrap process...');
        await _initExtraServices();
        await _initializeRepositories();
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

  @override
  LoginViewModel get loginViewModel => _loginViewModel;

  @override
  ClientsViewModel get clientsViewModel => _clientViewModel;

  @override
  ImagesPicker get imagesPicker => _imagesPicker;
}

class _DevBootstrapper extends _DefaultBootstrapper {
  _DevBootstrapper() : super(Flavor.dev);
}

class _ProdBootstrapper extends _DefaultBootstrapper {
  _ProdBootstrapper() : super(Flavor.dev);
}
