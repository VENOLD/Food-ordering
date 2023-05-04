import 'dart:convert';

class Restaurants {
  final String restaurant1;
  final String restaurant2;
  final String restaurant3;
  final String restaurant4;
  final String restaurant5;
  final String restaurant6;
  final String restaurant7;
  final String restaurant8;
  final String restaurant9;
  final String restaurant10;

  Restaurants({
    required this.restaurant1,
    required this.restaurant2,
    required this.restaurant3,
    required this.restaurant4,
    required this.restaurant5,
    required this.restaurant6,
    required this.restaurant7,
    required this.restaurant8,
    required this.restaurant9,
    required this.restaurant10,
  });

  Map<String, dynamic> toMap() {
    return {
      'restaurant1': restaurant1,
      'restaurant2': restaurant2,
      'restaurant3': restaurant3,
      'restaurant4': restaurant4,
      'restaurant5': restaurant5,
      'restaurant6': restaurant6,
      'restaurant7': restaurant7,
      'restaurant8': restaurant8,
      'restaurant9': restaurant9,
      'restaurant10': restaurant10,
    };
  }

  factory Restaurants.fromMap(Map<String, dynamic> map) {
    return Restaurants(
      restaurant1: map['restaurant1'] ?? '',
      restaurant2: map['restaurant2'] ?? '',
      restaurant3: map['restaurant3'] ?? '',
      restaurant4: map['restaurant4'] ?? '',
      restaurant5: map['restaurant5'] ?? '',
      restaurant6: map['restaurant6'] ?? '',
      restaurant7: map['restaurant7'] ?? '',
      restaurant8: map['restaurant8'] ?? '',
      restaurant9: map['restaurant9'] ?? '',
      restaurant10: map['restaurant10'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurants.fromJson(String source) =>
      Restaurants.fromMap(json.decode(source));

  Restaurants copyWith({
    String? restaurant1,
    String? restaurant2,
    String? restaurant3,
    String? restaurant4,
    String? restaurant5,
    String? restaurant6,
    String? restaurant7,
    String? restaurant8,
    String? restaurant9,
    String? restaurant10,
  }) {
    return Restaurants(
      restaurant1: restaurant1 ?? this.restaurant1,
      restaurant2: restaurant2 ?? this.restaurant2,
      restaurant3: restaurant3 ?? this.restaurant3,
      restaurant4: restaurant4 ?? this.restaurant4,
      restaurant5: restaurant5 ?? this.restaurant5,
      restaurant6: restaurant6 ?? this.restaurant6,
      restaurant7: restaurant7 ?? this.restaurant7,
      restaurant8: restaurant8 ?? this.restaurant8,
      restaurant9: restaurant9 ?? this.restaurant9,
      restaurant10: restaurant10 ?? this.restaurant10,
    );
  }
}
