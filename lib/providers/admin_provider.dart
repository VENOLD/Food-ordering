import 'package:flutter/foundation.dart';
import 'package:insa_cafeteria/models/admin.dart';

class AdminProvider extends ChangeNotifier {
  Admin _admin = Admin(
    id: '',
    name: '',
    phoneNumber: '',
    password: '',
    address: '',
    type: '',
    token: '',
  );
  Admin get admin => _admin;
  void setAdmin(String admin) {
    _admin = Admin.fromJson(admin);
    notifyListeners();
  }

  void setUserFromModel(Admin admin) {
    _admin = admin;
    notifyListeners();
  }
}
