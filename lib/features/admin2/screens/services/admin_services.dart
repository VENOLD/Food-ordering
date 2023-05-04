import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:insa_cafeteria/constants/error_handling.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/constants/utils.dart';
import 'package:insa_cafeteria/features/admin/screens/add_admin_screen2.dart';
import 'package:insa_cafeteria/features/admin/screens/sorry.dart';
import 'package:insa_cafeteria/features/admin2/models/sales.dart';
import 'package:insa_cafeteria/features/auth/screens/SignIn_Gojo.dart';
import 'package:insa_cafeteria/models/food_gojo.dart';
import 'package:http/http.dart' as http;
import 'package:insa_cafeteria/models/order_gojo.dart';
import 'package:insa_cafeteria/providers/admin2_provider.dart';
import 'package:insa_cafeteria/providers/admin_provider.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Admin2Services {
  void sellFood2({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
    required double vat,
  }) async {
    final userProvider = Provider.of<Admin2Provider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('insa', 'pcpxjgly');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      FoodGojo food = FoodGojo(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
        vat: vat,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-food2'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.admin.token,
        },
        body: food.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Food Added Successfully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

// get all the products
  Future<List<FoodGojo>> fetchAllFoods(BuildContext context) async {
    final userProvider = Provider.of<Admin2Provider>(context, listen: false);
    List<FoodGojo> foodList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-food2'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.admin.token,
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

  void deleteFood({
    required BuildContext context,
    required FoodGojo food,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<Admin2Provider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-food2'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.admin.token,
        },
        body: jsonEncode({
          'id': food.id,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void updateQuantity({
    required BuildContext context,
    required FoodGojo quantity,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/quantity'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'quantity': quantity,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          const Text('Updated Success!');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<OrderGojo>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<Admin2Provider>(context, listen: false);
    List<OrderGojo> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders2'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.admin.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              OrderGojo.fromJson(
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

    return orderList;
  }

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required OrderGojo order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<Admin2Provider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status2'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.admin.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<Admin2Provider>(context, listen: false);
    List<SalesGojo> sales = [];
    int totalEarning = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics2'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.admin.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            SalesGojo('የፆም', response['fastingEarnings']),
            SalesGojo('የፍስክ', response['feastEarnings']),
            SalesGojo('ትኩስ', response['HotDrinksEarnings']),
            SalesGojo('ለስላሳ', response['SoftDrinksEarnings']),
            SalesGojo('ቡፌ', response['BuffetEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }

  void logOUtt(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
          context, SignInAdminGojo.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInBose({
    required BuildContext context,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin-admin'),
        body: jsonEncode({
          'phoneNumber': phoneNumber,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<Admin2Provider>(context, listen: false)
              .setAdmin(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamed(
            context,
            Provider.of<AdminProvider>(context, listen: false).admin.type ==
                    'Bose'
                ? AddAdmin.routeName
                : Sorry.routeName,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
