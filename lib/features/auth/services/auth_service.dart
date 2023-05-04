import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:insa_cafeteria/common/widgets/bottom_bar.dart';
import 'package:insa_cafeteria/constants/error_handling.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/constants/utils.dart';
import 'package:insa_cafeteria/features/admin/screens/admin_screen.dart';
import 'package:insa_cafeteria/features/admin2/screens/admin_screen.dart';
import 'package:insa_cafeteria/features/home/screens/cafe_choosing.dart';
import 'package:insa_cafeteria/models/admin.dart';
import 'package:insa_cafeteria/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:insa_cafeteria/providers/admin2_provider.dart';
import 'package:insa_cafeteria/providers/admin_provider.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    try {
      User user = User(
        id: '',
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        address: '',
        type: '',
        token: '',
        cart: [],
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
              context,
              'Account created! Please Login!',
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'phoneNumber': phoneNumber,
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
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
              context,
              Provider.of<UserProvider>(context, listen: false).user.type ==
                      'User'
                  ? CafeChoosing.routeName
                  : AdminScreen.routeName,
              (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signUpadmin({
    required BuildContext context,
    required String phoneNumber,
    required String name,
    required String password,
  }) async {
    try {
      Admin admin = Admin(
        id: '',
        name: name,
        phoneNumber: phoneNumber,
        password: password,
        address: '',
        type: '',
        token: '',
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup-admin'),
        body: admin.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
              context,
              'Account created!!',
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInAdmin({
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
          Provider.of<AdminProvider>(context, listen: false).setAdmin(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
              context, AdminScreen.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInAdmin2({
    required BuildContext context,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin-admin2'),
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
          Navigator.pushNamedAndRemoveUntil(
              context, AdminScreen2.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getAdminData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var adminProvider = Provider.of<AdminProvider>(context, listen: false);
        adminProvider.setAdmin(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getAdminData2(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var adminProvider = Provider.of<Admin2Provider>(context, listen: false);
        adminProvider.setAdmin(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
