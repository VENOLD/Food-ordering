import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/loader.dart';
import 'package:insa_cafeteria/features/account/widgets/single_item.dart';
import 'package:insa_cafeteria/features/admin/screens/services/admin_services.dart';
import 'package:insa_cafeteria/features/order_details/screens/order_detail.dart';
import 'package:insa_cafeteria/models/order.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/screen_orders';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

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
    final user = Provider.of<UserProvider>(context).user;
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
                  child: Column(
                    children: [
                      SingleItem(
                        image: orderData.foods[0].images[0],
                      ),
                      Text(
                        textAlign: TextAlign.start,
                        '${user.phoneNumber}',
                        style: const TextStyle(color: Colors.red),
                      ),
                      Icon(Icons.call)
                    ],
                  ),
                ),
              );
            },
          );
  }
}
