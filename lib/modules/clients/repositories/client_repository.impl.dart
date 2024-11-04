import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:minimal/modules/clients/models/clients.dart';
import 'package:minimal/modules/clients/models/edit_client_request.dart';
import 'package:minimal/modules/clients/models/get_clients_request.dart';
import 'package:minimal/modules/clients/models/remove_client_request.dart';

import '../../../core/endpoints.dart';
import '../../../services/network/network_client.dart';
import '../models/add_client_request.dart';
import 'client_repository.dart';

class ClientRepositoryImpl implements ClientRepository {
  ClientRepositoryImpl({
    required NetworkClient networkClient,
    required Endpoints endpoints,
  })  : _networkClient = networkClient,
        _endpoints = endpoints;

  final NetworkClient _networkClient;
  final Endpoints _endpoints;

  @override
  Future<Either<Fail, List<Client>>> getClients() async {
    final request = GetClientsRequest(
      url: _endpoints.getClientsEndPoint,
    );

    try {
      final response = await _networkClient.get(
        Uri.parse(request.url),
        headers: request.headers,
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body) as Map<String, dynamic>;
        final clients = List<Client>.from(
            body['data'].map((client) => Client.fromJson(client)));
        return right(clients);
      } else {
        return left(Fail(response.body));
      }
    } catch (e) {
      return left(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, bool>> addClient(Client client) async {
    final request = AddClientRequest(
      url: _endpoints.addClientEndPoint,
      client: client,
    );
    try {
      final response = await _networkClient.post(
        Uri.parse(request.url),
        body: request.body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(true);
      } else {
        return left(Fail(response.body));
      }
    } catch (e) {
      return left(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, bool>> updateClient(Client client) async {
    final request = EditClientRequest(
      clientToEdit: client,
      url: _endpoints.editClient,
    );

    try {
      final response = await _networkClient.post(
        Uri.parse(request.url),
        body: request.body,
        headers: request.headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(true);
      } else {
        return left(Fail(response.body));
      }
    } catch (e) {
      return left(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, bool>> removeClient(String clientId) async {
    final request = RemoveClientRequest(
        clientId: clientId, url: _endpoints.removeClientEndPoint);
    try {
      final response = await _networkClient.delete(
        Uri.parse(request.url),
        headers: request.headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(true);
      } else {
        return left(Fail('Error: backend error'));
      }
    } catch (e) {
      return left(Fail(e.toString()));
    }
  }
}

String fakeResponse = '''{
   "data":[
      {
         "id":1,
         "firstname":"Matias",
         "lastname":"Camiletti",
         "email":"matias@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":null,
         "caption":null,
         "created_at":"2024-10-30T11:10:01.000Z",
         "updated_at":"2024-10-30T11:10:01.000Z",
         "user_id":3
      },
      {
         "id":2,
         "firstname":"Matias2",
         "lastname":"Camiletti2",
         "email":"matias2@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":"22",
         "caption":"22",
         "created_at":"2024-10-30T11:10:14.000Z",
         "updated_at":"2024-10-30T11:10:14.000Z",
         "user_id":3
      },
      {
         "id":20,
         "firstname":"hdhe",
         "lastname":"hdrhe",
         "email":"jjdjf@df.ee",
         "address":null,
         "photo":null,
         "caption":null,
         "created_at":"2024-11-01T03:44:07.000Z",
         "updated_at":"2024-11-01T03:44:07.000Z",
         "user_id":3
      },
      {
         "id":21,
         "firstname":"bbdd",
         "lastname":"hdjdjd",
         "email":"beje@f.fff",
         "address":null,
         "photo":null,
         "caption":null,
         "created_at":"2024-11-01T03:44:31.000Z",
         "updated_at":"2024-11-01T03:44:31.000Z",
         "user_id":3
      },
      {
         "id":22,
         "firstname":"Hola",
         "lastname":"Hola",
         "email":"jfjf@fff.fff",
         "address":null,
         "photo":null,
         "caption":null,
         "created_at":"2024-11-01T12:20:17.000Z",
         "updated_at":"2024-11-01T12:20:17.000Z",
         "user_id":3
      },
      {
         "id":23,
         "firstname":"Matias",
         "lastname":"Camiletti",
         "email":"matias@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":null,
         "caption":null,
         "created_at":"2024-11-01T22:58:54.000Z",
         "updated_at":"2024-11-01T22:58:54.000Z",
         "user_id":3
      },
      {
         "id":24,
         "firstname":"Matias",
         "lastname":"Camiletti",
         "email":"matias@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":null,
         "caption":null,
         "created_at":"2024-11-01T23:07:09.000Z",
         "updated_at":"2024-11-01T23:07:09.000Z",
         "user_id":3
      },
      {
         "id":25,
         "firstname":"Matias2",
         "lastname":"Camiletti2",
         "email":"matias2@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":"22",
         "caption":"22",
         "created_at":"2024-11-02T05:23:08.000Z",
         "updated_at":"2024-11-02T05:23:08.000Z",
         "user_id":3
      },
      {
         "id":26,
         "firstname":"Matias",
         "lastname":"Camiletti",
         "email":"matias@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":null,
         "caption":null,
         "created_at":"2024-11-02T11:37:30.000Z",
         "updated_at":"2024-11-02T11:37:30.000Z",
         "user_id":3
      },
      {
         "id":26,
         "firstname":"Matias",
         "lastname":"Camiletti",
         "email":"matias@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":null,
         "caption":null,
         "created_at":"2024-11-02T11:37:30.000Z",
         "updated_at":"2024-11-02T11:37:30.000Z",
         "user_id":3
      },
      {
         "id":26,
         "firstname":"Matias",
         "lastname":"Camiletti",
         "email":"matias@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":null,
         "caption":null,
         "created_at":"2024-11-02T11:37:30.000Z",
         "updated_at":"2024-11-02T11:37:30.000Z",
         "user_id":3
      },
      {
         "id":26,
         "firstname":"Matias",
         "lastname":"Camiletti",
         "email":"matias@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":null,
         "caption":null,
         "created_at":"2024-11-02T11:37:30.000Z",
         "updated_at":"2024-11-02T11:37:30.000Z",
         "user_id":3
      },
      {
         "id":26,
         "firstname":"Matias",
         "lastname":"Camiletti",
         "email":"matias@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":null,
         "caption":null,
         "created_at":"2024-11-02T11:37:30.000Z",
         "updated_at":"2024-11-02T11:37:30.000Z",
         "user_id":3
      },
      {
         "id":26,
         "firstname":"Matias",
         "lastname":"Camiletti",
         "email":"matias@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":null,
         "caption":null,
         "created_at":"2024-11-02T11:37:30.000Z",
         "updated_at":"2024-11-02T11:37:30.000Z",
         "user_id":3
      },
      {
         "id":26,
         "firstname":"Matias",
         "lastname":"Camiletti",
         "email":"matias@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":null,
         "caption":null,
         "created_at":"2024-11-02T11:37:30.000Z",
         "updated_at":"2024-11-02T11:37:30.000Z",
         "user_id":3
      },
      {
         "id":26,
         "firstname":"Matias",
         "lastname":"Camiletti",
         "email":"matias@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":null,
         "caption":null,
         "created_at":"2024-11-02T11:37:30.000Z",
         "updated_at":"2024-11-02T11:37:30.000Z",
         "user_id":3
      },
      {
         "id":26,
         "firstname":"Matias",
         "lastname":"Camiletti",
         "email":"matias@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":null,
         "caption":null,
         "created_at":"2024-11-02T11:37:30.000Z",
         "updated_at":"2024-11-02T11:37:30.000Z",
         "user_id":3
      },
      {
         "id":26,
         "firstname":"Matias",
         "lastname":"Camiletti",
         "email":"matias@agencycoda.com",
         "address":"Buenos Aires, Argentina",
         "photo":null,
         "caption":null,
         "created_at":"2024-11-02T11:37:30.000Z",
         "updated_at":"2024-11-02T11:37:30.000Z",
         "user_id":3
      }
   ]
}''';
