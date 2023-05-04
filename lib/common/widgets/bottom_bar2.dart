import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/features/account/screens/account_screen.dart';
import 'package:insa_cafeteria/features/cart/screens/cart_screen.dart';
import 'package:insa_cafeteria/features/cart_gojo/screens/cart_screen.dart';
import 'package:insa_cafeteria/features/home/screens/home_screen_gojo.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BottomBar2 extends StatefulWidget {
  static const String routeName = '/gojo_home';
  const BottomBar2({Key? key}) : super(key: key);

  @override
  State<BottomBar2> createState() => _BottomBar2State();
}

class _BottomBar2State extends State<BottomBar2> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  List<Widget> pages = [
    const HomeScreen2(),
    const AccountScreen(),
    const CartScreenGojo(),
  ];
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCart = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
        body: pages[_page],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor: Colors.red,
          unselectedItemColor: GlobalVariable.unselectedNavBarColor,
          backgroundColor: GlobalVariable.backgroundColor,
          iconSize: 28,
          onTap: updatePage,
          items: [
            //Hpme page
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 0
                          ? GlobalVariable.selectedNavBarColor
                          : GlobalVariable.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.home_outlined,
                ),
              ),
              label: 'Home',
            ),
            //Account
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 1
                          ? GlobalVariable.selectedNavBarColor
                          : GlobalVariable.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.person_outline_outlined,
                ),
              ),
              label: 'Account',
            ),
            //Cart
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 2
                          ? GlobalVariable.selectedNavBarColor
                          : GlobalVariable.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: badges.Badge(
                  badgeContent: Text(userCart.toString()),
                  child: const Icon(
                    Icons.food_bank_sharp,
                  ),
                ),
              ),
              label: 'Food Cart',
            ),
          ],
        ));
  }
}
