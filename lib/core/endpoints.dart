class Endpoints {
  Endpoints({
    required this.loginEndPoint,
  });

  final String loginEndPoint;

  factory Endpoints.fromJson(Map<String, dynamic> json) {
    return Endpoints(
      loginEndPoint: json[_AttributesKeys.loginEndPoint] as String,
    );
  }
}

abstract class _AttributesKeys {
  static const loginEndPoint = 'loginEndPoint';
}
