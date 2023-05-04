import 'dart:convert';

class AdminGojo {
  final String id;
  final String password;
  final String name;
  final String phoneNumber;
  final String address;
  final String type;
  final String token;

  AdminGojo({
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

  factory AdminGojo.fromMap(Map<String, dynamic> map) {
    return AdminGojo(
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

  factory AdminGojo.fromJson(String source) =>
      AdminGojo.fromMap(json.decode(source));

  AdminGojo copyWith({
    String? id,
    String? name,
    String? password,
    String? phoneNumber,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return AdminGojo(
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
