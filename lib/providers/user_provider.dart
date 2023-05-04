import 'package:flutter/foundation.dart';
import 'package:insa_cafeteria/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    phoneNumber: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );
  User get user => _user;
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
