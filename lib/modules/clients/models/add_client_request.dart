import 'dart:convert';

import 'package:minimal/general_models/network_request.dart';
import 'package:minimal/modules/clients/models/clients.dart';

class AddClientRequest extends NetworkRequest {
  AddClientRequest({required super.url, required Client client})
      : _client = client;

  final Client _client;

  @override
  String? get body => json.encode(_client.toJson());
}
