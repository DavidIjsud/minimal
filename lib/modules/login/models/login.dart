class LoginResponse {
  final int? id;
  final String? email;
  final String? tokenType;
  final String? accessToken;

  LoginResponse({
    this.id,
    this.email,
    this.tokenType,
    this.accessToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json.containsKey("id") && json["id"] != null ? json["id"] : null,
        email: json.containsKey("email") && json["email"] != null
            ? json["email"]
            : null,
        tokenType: json.containsKey("token_type") && json["token_type"] != null
            ? json["token_type"]
            : null,
        accessToken:
            json.containsKey("access_token") && json["access_token"] != null
                ? json["access_token"]
                : null,
      );
}
