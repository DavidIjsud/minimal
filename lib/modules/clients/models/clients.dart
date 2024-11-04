import 'package:equatable/equatable.dart';

class Clients extends Equatable {
  final List<Client>? clients;

  const Clients({
    this.clients,
  });

  factory Clients.fromJson(Map<String, dynamic> json) => Clients(
        clients: json.containsKey('data') == false || json["data"] == null
            ? []
            : List<Client>.from(json["data"]!.map((x) => Client.fromJson(x))),
      );

  @override
  List<Object?> get props => [
        clients,
      ];
}

class Client extends Equatable {
  final int? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? address;
  final String? photo;
  final String? caption;
  final int? userId;

  const Client({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.address,
    this.photo,
    this.caption,
    this.userId,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json.containsKey('id') && json["id"] != null ? json["id"] : null,
        firstname: json.containsKey("firstname") && json["firstname"] != null
            ? json["firstname"]
            : null,
        lastname: json.containsKey("lastname") && json["lastname"] != null
            ? json["lastname"]
            : null,
        email: json.containsKey("email") && json["email"] != null
            ? json["email"]
            : null,
        address: json.containsKey("address") && json["address"] != null
            ? json["address"]
            : null,
        photo: json.containsKey("photo") && json["photo"] != null
            ? json["photo"]
            : null,
        caption: json.containsKey("caption") && json["caption"] != null
            ? json["caption"]
            : null,
        userId: json.containsKey("user_id") && json["user_id"] != null
            ? json["user_id"]
            : null,
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname ?? "",
        "lastname": lastname ?? "",
        "email": email ?? "",
        "address": address ?? "",
        "photo": photo ?? "",
        "caption": caption ?? "",
      };

  Client copyWith({
    int? id,
    String? firstname,
    String? lastname,
    String? email,
    String? address,
    String? photo,
    String? caption,
    int? userId,
  }) {
    return Client(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      address: address ?? this.address,
      photo: photo ?? this.photo,
      caption: caption ?? this.caption,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstname,
        lastname,
        email,
        address,
        photo,
        caption,
        userId,
      ];
}
