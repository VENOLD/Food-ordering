import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/custom_button.dart';
import 'package:insa_cafeteria/features/address/screens/address_screen.dart';
import 'package:insa_cafeteria/features/address_Gojo/screens/address_screen.dart';
import 'package:insa_cafeteria/features/cart/widgets/cart_subtotal.dart';
import 'package:insa_cafeteria/features/cart_gojo/widgets/cart_food.dart';
import 'package:insa_cafeteria/features/home/search/screens/search_screens.dart';
import 'package:insa_cafeteria/features/home/widgets/address_box.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartScreenGojo extends StatefulWidget {
  const CartScreenGojo({Key? key}) : super(key: key);

  @override
  State<CartScreenGojo> createState() => _CartScreenGojoState();
}

class _CartScreenGojoState extends State<CartScreenGojo> {
  void navigateToSearchScreens(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddress(double sum) {
    Navigator.pushNamed(
      context,
      AddressScreenGojo.routeName,
      arguments: sum.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double sum = 0;
    user.cart
        .map(
            (e) => sum += e['quantity'] * e['food']['price'] + e['food']['vat'])
        .toList();
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
                  color: Colors.orange,
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
        child: Column(
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: 'Order Now (${user.cart.length}) Food/Drinks ',
                onTap: () => navigateToAddress(sum),
                color: Colors.yellow[600],
              ),
            ),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            ListView.builder(
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CartFoodGojo(index: index);
                })
          ],
        ),
      ),
    );
  }
}
