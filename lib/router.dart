import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/bottom_bar.dart';
import 'package:insa_cafeteria/common/widgets/bottom_bar2.dart';
import 'package:insa_cafeteria/features/address/screens/address_screen.dart';
import 'package:insa_cafeteria/features/address_Gojo/screens/address_screen.dart';
import 'package:insa_cafeteria/features/admin/screens/account.dart';
import 'package:insa_cafeteria/features/admin/screens/add_admin_screen.dart';
import 'package:insa_cafeteria/features/admin/screens/add_admin_screen2.dart';
import 'package:insa_cafeteria/features/admin/screens/add_food_screen.dart';
import 'package:insa_cafeteria/features/admin/screens/admin_screen.dart';
import 'package:insa_cafeteria/features/admin/screens/orders_screen.dart';
import 'package:insa_cafeteria/features/admin/screens/sorry.dart';
import 'package:insa_cafeteria/features/admin2/screens/add_food_screen.dart';
import 'package:insa_cafeteria/features/admin2/screens/admin_screen.dart';
import 'package:insa_cafeteria/features/admin2/screens/order_screen.dart';
import 'package:insa_cafeteria/features/auth/screens/SignIn.dart';
import 'package:insa_cafeteria/features/auth/screens/SignIn_Gojo.dart';
import 'package:insa_cafeteria/features/auth/screens/SignUp.dart';
import 'package:insa_cafeteria/features/auth/screens/forgot_password.dart';
import 'package:insa_cafeteria/features/auth/screens/signin_mezenagna_cashier.dart';
import 'package:insa_cafeteria/features/cart/screens/cart_screen.dart';
import 'package:insa_cafeteria/features/food_detail_gojo/screens/food_detail.dart';
import 'package:insa_cafeteria/features/food_details/screens/food_detail.dart';
import 'package:insa_cafeteria/features/home/screens/cafe_choosing.dart';
import 'package:insa_cafeteria/features/home/screens/category_deals_screen.dart';
import 'package:insa_cafeteria/features/home/screens/category_screen2.dart';
import 'package:insa_cafeteria/features/home/screens/home_screen_gojo.dart';
import 'package:insa_cafeteria/features/home/search/screens/search_screens.dart';
import 'package:insa_cafeteria/features/order_details/screens/order_detail.dart';
import 'package:insa_cafeteria/models/food.dart';
import 'package:insa_cafeteria/models/food_gojo.dart';
import 'package:insa_cafeteria/models/order.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignUp.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUp(),
      );
    case SignIn.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignIn(),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
    case AdminScreen2.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen2(),
      );
    case Account.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Account(),
      );

    case HomeScreen2.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen2(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case BottomBar2.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar2(),
      );
    case AddFoodScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddFoodScreen(),
      );
    case AddFoodScreenGojo.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddFoodScreenGojo(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case CategoryDealsScreenGojo.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreenGojo(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case FoodDetailScreen.routeName:
      var food = routeSettings.arguments as Food;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => FoodDetailScreen(
          food: food,
        ),
      );
    case FoodDetailScreenGojo.routeName:
      var food = routeSettings.arguments as FoodGojo;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => FoodDetailScreenGojo(
          food: food,
        ),
      );
    case AddressScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddressScreen(),
      );
    case AddressScreenGojo.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreenGojo(
          totalAmount: totalAmount,
        ),
      );
    case OrderDetailScreens.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreens(
          order: order,
        ),
      );
    case OrdersScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrdersScreen(),
      );
    case OrdersScreenGojo.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrdersScreenGojo(),
      );
    case Bose.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Bose(),
      );
    case AddAdmin.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddAdmin(),
      );
    case Sorry.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Sorry(),
      );
    case SignInAdminGojo.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignInAdminGojo(),
      );
    case SignInAdmin2.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignInAdmin2(),
      );
    case ForgotPassword.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ForgotPassword(),
      );
    case CafeChoosing.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CafeChoosing(),
      );
    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CartScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen Does Not Exist!'),
          ),
        ),
      );
  }
}
