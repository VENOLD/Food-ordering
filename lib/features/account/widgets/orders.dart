import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/loader.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/features/account/services/account_services.dart';
import 'package:insa_cafeteria/features/account/widgets/single_item.dart';
import 'package:insa_cafeteria/features/order_details/screens/order_detail.dart';
import 'package:insa_cafeteria/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrderState();
}

class _OrderState extends State<Orders> {
  List<Order>? orders;

  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: const Text(
                    'Your Orders',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    right: 15,
                  ),
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: GlobalVariable.selectedNavBarColor,
                    ),
                  ),
                ),
              ]),
              Container(
                height: 170,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 0,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          OrderDetailScreens.routeName,
                          arguments: orders![index],
                        );
                      },
                      child: SingleItem(
                        image: orders![index].foods[0].images[0],
                      ),
                    );
                  },
                ),
              )
            ],
          );
  }
}
