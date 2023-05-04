import 'dart:convert';

import 'package:insa_cafeteria/models/rating.dart';

class FoodGojo {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  final List<Rating>? rating;
  final double vat;

  FoodGojo({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    this.rating,
    required this.vat,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'rating': rating,
      'vat': vat,
    };
  }

  factory FoodGojo.fromMap(Map<String, dynamic> map) {
    return FoodGojo(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
      vat: map['vat']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodGojo.fromJson(String source) =>
      FoodGojo.fromMap(json.decode(source));
}
