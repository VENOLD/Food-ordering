import 'dart:convert';
import 'package:insa_cafeteria/models/food_gojo.dart';

class OrderGojo {
  final String id;
  final List<FoodGojo> foods;
  final List<int> quantity;
  final String userId;
  final int status;
  final int orderedAt;
  final double totalPrice;

  OrderGojo({
    required this.id,
    required this.foods,
    required this.quantity,
    required this.orderedAt,
    required this.userId,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'foods': foods.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'orderedAt': orderedAt,
      'userId': userId,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory OrderGojo.fromMap(Map<String, dynamic> map) {
    return OrderGojo(
      id: map['_id'] ?? '',
      foods: List<FoodGojo>.from(
          map['foods']?.map((x) => FoodGojo.fromMap(x['food']))),
      quantity: List<int>.from(
        map['foods']?.map(
          (x) => x['quantity'],
        ),
      ),
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      userId: map['userId'] ?? '',
      status: map['status']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderGojo.fromJson(String source) =>
      OrderGojo.fromMap(json.decode(source));
}
