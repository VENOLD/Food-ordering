import 'dart:convert';

import 'package:insa_cafeteria/models/food.dart';

class Order {
  final String id;
  final List<Food> foods;
  final List<int> quantity;
  final String userId;
  final int status;
  final int orderedAt;
  final double totalPrice;


  Order(
      {required this.id,
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

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      foods: List<Food>.from(map['foods']?.map((x) => Food.fromMap(x['food']))),
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

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
