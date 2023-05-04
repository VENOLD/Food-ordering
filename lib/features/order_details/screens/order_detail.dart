import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/custom_button.dart';
import 'package:insa_cafeteria/features/admin/screens/services/admin_services.dart';
import 'package:insa_cafeteria/features/home/search/screens/search_screens.dart';
import 'package:insa_cafeteria/models/order.dart';
import 'package:insa_cafeteria/providers/admin_provider.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailScreens extends StatefulWidget {
  static const String routeName = '/order-detaild';
  final Order order;
  const OrderDetailScreens({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailScreens> createState() => _OrderDetailScreensState();
}

class _OrderDetailScreensState extends State<OrderDetailScreens> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();
  void navigateToSearchScreens(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

// only for admin
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
        context: context,
        status: status + 1,
        order: widget.order,
        onSuccess: () {});

    setState(() {
      currentStep += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final admin = Provider.of<AdminProvider>(context).admin;
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 228, 150, 31))),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 228, 150, 31),
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreens,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Food Here.',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'View Order Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.black12,
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Date:     ${DateFormat().format(
                    DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt),
                  )}'),
                  Text('Invoice No:     ${widget.order.id}'),
                  const Text('Vat:                 15%   '),
                  Text('Total Price:     ${widget.order.totalPrice} Birr'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              ' Ordered Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget.order.foods.length; i++)
                    Row(
                      children: [
                        Image.network(
                          widget.order.foods[i].images[0],
                          height: 120,
                          width: 120,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.foods[i].name,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Quantity: ${widget.order.quantity[i]}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              ' Tracking Your Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if (admin.type == 'admin' || admin.type == 'Bose') {
                      return CustomButton(
                        color: const Color.fromARGB(255, 181, 127, 46),
                        text: 'Done',
                        onTap: () => changeOrderStatus(details.currentStep),
                      );
                    }
                    return const SizedBox();
                  },
                  steps: [
                    Step(
                        title: const Text('Accepted'),
                        content: const Text('Your Order has been accepted'),
                        isActive: currentStep > 0,
                        state: currentStep > 0
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text('Completed'),
                        content: const Text(
                            'Your Order has been completed, thank you for choosing Gojo Restaurant'),
                        isActive: currentStep >= 1,
                        state: currentStep >= 1
                            ? StepState.complete
                            : StepState.indexed),
                  ]),
            ),
          ],
        ),
      )),
    );
  }
}
