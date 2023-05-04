import 'package:flutter/foundation.dart';
import 'package:insa_cafeteria/models/restaurants.dart';

class RestaurantProvider extends ChangeNotifier {
  Restaurants _restaurants = Restaurants(
    restaurant1: '',
    restaurant2: '',
    restaurant3: '',
    restaurant4: '',
    restaurant5: '',
    restaurant6: '',
    restaurant7: '',
    restaurant8: '',
    restaurant9: '',
    restaurant10: '',
  );
  Restaurants get restaurants => _restaurants;
  void setUser(String user) {
    _restaurants = Restaurants.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(Restaurants restaurants) {
    _restaurants = restaurants;
    notifyListeners();
  }
}
