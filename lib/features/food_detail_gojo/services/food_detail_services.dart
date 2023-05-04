import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insa_cafeteria/constants/error_handling.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/constants/utils.dart';
import 'package:insa_cafeteria/models/food_gojo.dart';
import 'package:insa_cafeteria/models/user.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class FoodDetailsServicesGojo {
  void addToCartGojo({
    required BuildContext context,
    required FoodGojo food,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart-gojo'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': food.id!,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
          showSnackBar(
            context,
            'Successfully Added',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void rateFood({
    required BuildContext context,
    required FoodGojo food,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-food-gojo'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': food.id!,
          'rating': rating,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
