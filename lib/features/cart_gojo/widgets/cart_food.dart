import 'package:flutter/material.dart';
import 'package:insa_cafeteria/features/cart_gojo/services/cart_services.dart';
import 'package:insa_cafeteria/features/food_detail_gojo/services/food_detail_services.dart';
import 'package:insa_cafeteria/models/food_gojo.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartFoodGojo extends StatefulWidget {
  final int index;
  const CartFoodGojo({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartFoodGojo> createState() => _CartFoodGojoState();
}

class _CartFoodGojoState extends State<CartFoodGojo> {
  final FoodDetailsServicesGojo foodDetailsServices = FoodDetailsServicesGojo();
  final CartServicesGojo cartServices = CartServicesGojo();
  void increaseQuantity(FoodGojo food) {
    foodDetailsServices.addToCartGojo(context: context, food: food);
  }

  void decreaseQuantity(FoodGojo food) {
    cartServices.removefromCartGojo(context: context, food: food);
  }

  @override
  Widget build(BuildContext context) {
    final foodCart = context.watch<UserProvider>().user.cart[widget.index];
    final food = FoodGojo.fromMap(foodCart['food']);
    final quantity = foodCart['quantity'];
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                food.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      food.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                    ),
                    child: Text(
                      '${(food.price) + (food.vat)} Birr',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => decreaseQuantity(food),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1.5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Text(
                          quantity.toString(),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => increaseQuantity(food),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
