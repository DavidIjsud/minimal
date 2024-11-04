import 'dart:convert';

import 'package:minimal/general_models/network_request.dart';
import 'package:minimal/modules/clients/models/clients.dart';

class EditClientRequest extends NetworkRequest {
  EditClientRequest({
    required this.clientToEdit,
    required String url,
  }) : super(url: url.replaceAll('{clientId}', clientToEdit.userId.toString()));
  final Client clientToEdit;

  @override
  String? get body => jsonEncode(clientToEdit.toJson());
}
