import 'dart:convert';

class Admin {
  final String id;
  final String password;
  final String name;
  final String phoneNumber;
  final String address;
  final String type;
  final String token;

  Admin({
    required this.id,
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.type,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'password': password,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'type': type,
      'token': token,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Admin.fromJson(String source) => Admin.fromMap(json.decode(source));

  Admin copyWith({
    String? id,
    String? name,
    String? password,
    String? phoneNumber,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return Admin(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
    );
  }
}
