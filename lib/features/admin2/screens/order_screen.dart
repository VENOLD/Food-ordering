import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/loader.dart';
import 'package:insa_cafeteria/features/account/widgets/single_item.dart';
import 'package:insa_cafeteria/features/admin2/screens/services/admin_services.dart';
import 'package:insa_cafeteria/features/order_details/screens/order_detail.dart';
import 'package:insa_cafeteria/models/order_gojo.dart';

class OrdersScreenGojo extends StatefulWidget {
  static const String routeName = '/screen_orders_gojo';
  const OrdersScreenGojo({Key? key}) : super(key: key);

  @override
  State<OrdersScreenGojo> createState() => _OrdersScreenGojoState();
}

class _OrdersScreenGojoState extends State<OrdersScreenGojo> {
  List<OrderGojo>? orders;
  final Admin2Services adminServices = Admin2Services();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailScreens.routeName,
                      arguments: orderData);
                },
                child: SizedBox(
                  height: 140,
                  child: SingleItem(
                    image: orderData.foods[0].images[0],
                  ),
                ),
              );
            },
          );
  }
}
