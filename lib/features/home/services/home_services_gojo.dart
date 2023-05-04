import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:insa_cafeteria/constants/error_handling.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/constants/utils.dart';
import 'package:insa_cafeteria/models/food_gojo.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServicesGojo {
  Future<List<FoodGojo>> fetchCategoryFoods({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<FoodGojo> foodList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/food/gojo?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            foodList.add(
              FoodGojo.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return foodList;
  }

  Future<FoodGojo> fetchSaleOdDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    FoodGojo food = FoodGojo(
        name: '',
        description: '',
        quantity: 0,
        images: [],
        category: '',
        price: 0,
        vat: 0);
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/sale-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          food = FoodGojo.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return food;
  }
}
