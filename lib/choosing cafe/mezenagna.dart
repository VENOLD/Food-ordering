import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/bottom_bar.dart';
import 'package:insa_cafeteria/constants/util2.dart';
//import 'package:insa_cafeteria/providers/restaurant_provider.dart';
//import 'package:provider/provider.dart';

class Cafe1 extends StatefulWidget {
  static const String routeName = '/cafe1';
  const Cafe1({Key? key}) : super(key: key);

  @override
  State<Cafe1> createState() => _Cafe1State();
}

class _Cafe1State extends State<Cafe1> {
  // final user = Provider.of<RestaurantProvider>(context).restaurants;
  @override
  Widget build(BuildContext context) {
    Size size = Util(context).getScreenSize;
    return Material(
      borderRadius: BorderRadius.circular(1),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.pushNamed(context, BottomBar.routeName),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://thumbs.dreamstime.com/b/initial-letter-m-house-spoon-frok-logo-restaurant-initial-letter-m-house-spoon-frok-logo-restaurant-black-gold-color-127568397.jpg',
                  width: size.width * 0.22,
                  height: size.height * 0.09,
                ),
                const SizedBox(width: 17),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mezenagna Restaurant',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Fating, Feat , Hot Drinks\nSoft Drinks Buffet')
                      ],
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
