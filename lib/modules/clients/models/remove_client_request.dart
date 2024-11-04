import 'package:minimal/general_models/network_request.dart';

class RemoveClientRequest extends NetworkRequest {
  RemoveClientRequest({
    required this.clientId,
    required String url,
  }) : super(url: url.replaceAll('{clientId}', clientId));

  final String clientId;
}
