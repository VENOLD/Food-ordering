import 'package:flutter/foundation.dart';
import 'package:insa_cafeteria/models/admin_gojo.dart';

class Admin2Provider extends ChangeNotifier {
  AdminGojo _admin = AdminGojo(
    id: '',
    name: '',
    phoneNumber: '',
    password: '',
    address: '',
    type: '',
    token: '',
  );
  AdminGojo get admin => _admin;
  void setAdmin(String admin) {
    _admin = AdminGojo.fromJson(admin);
    notifyListeners();
  }

  void setUserFromModel(AdminGojo admin) {
    _admin = admin;
    notifyListeners();
  }
}
