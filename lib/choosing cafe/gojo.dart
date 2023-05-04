import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/bottom_bar2.dart';
import 'package:insa_cafeteria/constants/util2.dart';

class Cafe2 extends StatefulWidget {
  const Cafe2({Key? key}) : super(key: key);

  @override
  State<Cafe2> createState() => _Cafe2State();
}

class _Cafe2State extends State<Cafe2> {
  @override
  Widget build(BuildContext context) {
    Size size = Util(context).getScreenSize;
    return Material(
      borderRadius: BorderRadius.circular(1),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.pushNamed(context, BottomBar2.routeName),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://c8.alamy.com/comp/2HXFT53/letter-g-logo-with-chef-hat-spoon-and-fork-for-restaurant-logo-restaurant-logotype-on-letter-g-spoon-and-fork-concept-2HXFT53.jpg',
                  width: size.width * 0.22,
                  height: size.height * 0.09,
                ),
                const SizedBox(width: 17),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gojo Restaurant",
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
