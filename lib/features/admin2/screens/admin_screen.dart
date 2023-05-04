import 'package:flutter/material.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/features/admin2/screens/account.dart';
import 'package:insa_cafeteria/features/admin2/screens/analytics_screen.dart';
import 'package:insa_cafeteria/features/admin2/screens/order_screen.dart';
import 'package:insa_cafeteria/features/admin2/screens/post_screen.dart';

class AdminScreen2 extends StatefulWidget {
  static const String routeName = '/admin2';
  const AdminScreen2({Key? key}) : super(key: key);

  @override
  State<AdminScreen2> createState() => _AdminScreen2State();
}

class _AdminScreen2State extends State<AdminScreen2> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  List<Widget> pages = [
    const PostScreenGojo(),
    const AnalyticsScreenGojo(),
    const OrdersScreenGojo(),
    const AccountGojo(),
  ];
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.orange,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/Gojo_logo.png',
                  width: 120,
                  height: 45,
                ),
              ),
              const Text(
                'Cashier',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          ),
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariable.selectedNavBarColor,
        unselectedItemColor: GlobalVariable.unselectedNavBarColor,
        backgroundColor: GlobalVariable.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // POSTS
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
          // ANALYTICS
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
                Icons.analytics_outlined,
              ),
            ),
            label: 'Data',
          ),
          // ORDERS
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
              child: const Icon(
                Icons.all_inbox_outlined,
              ),
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 3
                        ? GlobalVariable.selectedNavBarColor
                        : GlobalVariable.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.account_circle_outlined,
              ),
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
