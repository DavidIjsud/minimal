import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:minimal/core/base_view_model.dart';
import 'package:minimal/modules/clients/repositories/client_repository.dart';

import '../../../services/storages/images_picker.dart';
import '../models/clients.dart';

class ClientsState extends Equatable {
  const ClientsState({
    this.isLoadingClients,
    this.clients,
    this.areClientsLoaded,
    this.errorMessage,
    this.amountOfClientsToShow,
    this.pathImagenSelectedFromStorage,
    this.isSavingClient,
    this.isClientSavedSuccess,
    this.isEditingClient,
    this.isClientEditedSuccess,
    this.isDeletingClient,
    this.isClientDeletedSuccess,
  });

  final bool? isLoadingClients;
  final List<Client>? clients;
  final bool? areClientsLoaded;
  final String? errorMessage;
  final int? amountOfClientsToShow;
  final String? pathImagenSelectedFromStorage;
  final bool? isSavingClient;
  final bool? isClientSavedSuccess;
  final bool? isEditingClient;
  final bool? isClientEditedSuccess;
  final bool? isDeletingClient;
  final bool? isClientDeletedSuccess;

  ClientsState copyWith({
    bool? isLoadingClients,
    List<Client>? clients,
    bool? areClientsLoaded,
    String? errorMessage,
    int? amountOfClientsToShow,
    String? pathImagenSelectedFromStorage,
    bool? isSavingClient,
    bool? isClientSavedSuccess,
    bool? isEditingClient,
    bool? isClientEditedSuccess,
    bool? isDeletingClient,
    bool? isClientDeletedSuccess,
  }) {
    return ClientsState(
      isLoadingClients: isLoadingClients ?? this.isLoadingClients,
      clients: clients ?? this.clients,
      areClientsLoaded: areClientsLoaded ?? this.areClientsLoaded,
      errorMessage: errorMessage ?? this.errorMessage,
      amountOfClientsToShow:
          amountOfClientsToShow ?? this.amountOfClientsToShow,
      pathImagenSelectedFromStorage:
          pathImagenSelectedFromStorage ?? this.pathImagenSelectedFromStorage,
      isSavingClient: isSavingClient ?? this.isSavingClient,
      isClientSavedSuccess: isClientSavedSuccess ?? this.isClientSavedSuccess,
      isEditingClient: isEditingClient ?? this.isEditingClient,
      isClientEditedSuccess:
          isClientEditedSuccess ?? this.isClientEditedSuccess,
      isDeletingClient: isDeletingClient ?? this.isDeletingClient,
      isClientDeletedSuccess:
          isClientDeletedSuccess ?? this.isClientDeletedSuccess,
    );
  }

  @override
  List<Object?> get props => [
        isLoadingClients,
        clients,
        areClientsLoaded,
        errorMessage,
        amountOfClientsToShow,
        pathImagenSelectedFromStorage,
        isSavingClient,
        isClientSavedSuccess,
        isEditingClient,
        isClientEditedSuccess,
        isDeletingClient,
        isClientDeletedSuccess,
      ];
}

class ClientsViewModel extends BaseViewModel<ClientsState> {
  ClientsViewModel({
    required ClientRepository clientRepository,
    required ImagesPicker pickerImage,
  })  : _clientRepository = clientRepository,
        pickerImage = pickerImage;

  final ClientRepository _clientRepository;
  final ImagesPicker pickerImage;

  void initViewModel() {
    initialize(const ClientsState(
      isLoadingClients: false,
      areClientsLoaded: false,
      amountOfClientsToShow: 0,
      clients: [],
    ));
  }

  Future<void> selectImageFromStorage() async {
    final path = await pickerImage.pickImage();
    setState(
      state!.copyWith(
        pathImagenSelectedFromStorage: path,
        isClientSavedSuccess: false,
      ),
    );
  }

  Future<void> unSelectedImageFromStorage() async {
    setState(
      state!.copyWith(
        pathImagenSelectedFromStorage: '',
        isClientSavedSuccess: false,
      ),
    );
  }

  int _getFirstFiveClientsToShow(List<Client> clients) {
    if (clients.isNotEmpty) {
      if (clients.length >= 5) {
        return 5;
      } else {
        return clients.length;
      }
    }

    return 0;
  }

  void loadNextFivesClients() {
    if (state!.clients!.length - state!.amountOfClientsToShow! >= 5) {
      setState(
        state!
            .copyWith(amountOfClientsToShow: state!.amountOfClientsToShow! + 5),
      );
    } else {
      setState(
        state!.copyWith(amountOfClientsToShow: state!.clients!.length),
      );
    }
  }

  Future<void> getClients() async {
    setState(state!.copyWith(
      isLoadingClients: true,
      isClientSavedSuccess: false,
      areClientsLoaded: false,
      isClientEditedSuccess: false,
      isEditingClient: false,
      isDeletingClient: false,
      isClientDeletedSuccess: false,
    ));
    final result = await _clientRepository.getClients();
    result.fold(
      (fail) {
        log('Error: ${fail.failure}');
        setState(
          state!.copyWith(
              errorMessage: fail.failure as String, isLoadingClients: false),
        );
      },
      (clients) {
        setState(state!.copyWith(
          clients: clients,
          areClientsLoaded: true,
          isLoadingClients: false,
          amountOfClientsToShow: _getFirstFiveClientsToShow(clients),
        ));
      },
    );
  }

  Future<void> addClient(Client client) async {
    setState(state!.copyWith(isSavingClient: true));
    final response = await _clientRepository.addClient(client);
    response.fold(
      (fail) {
        setState(state!.copyWith(
          errorMessage: fail.failure as String,
          isSavingClient: false,
          isClientSavedSuccess: false,
        ));
      },
      (isClientAdded) {
        setState(state!.copyWith(
          isSavingClient: false,
          isClientSavedSuccess: true,
        ));
        getClients();
      },
    );
  }

  Future<void> editClient(Client client) async {
    setState(state!.copyWith(isEditingClient: true));
    final response = await _clientRepository.updateClient(client);
    response.fold(
      (fail) {
        setState(state!.copyWith(
          errorMessage: fail.failure as String,
          isEditingClient: false,
          isClientEditedSuccess: false,
        ));
      },
      (isClientEdited) {
        setState(state!.copyWith(
          isEditingClient: false,
          isClientEditedSuccess: true,
        ));
        getClients();
      },
    );
  }

  Future<void> deleteClient(String clientId) async {
    setState(state!.copyWith(isDeletingClient: true));
    final response = await _clientRepository.removeClient(clientId);
    response.fold(
      (fail) {
        setState(state!.copyWith(
          errorMessage: fail.failure as String,
          isDeletingClient: false,
          isClientDeletedSuccess: false,
        ));
      },
      (isClientDeleted) {
        setState(state!.copyWith(
          isDeletingClient: false,
          isClientDeletedSuccess: true,
        ));
        getClients();
      },
    );
  }
}
