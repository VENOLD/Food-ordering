import 'package:flutter/material.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 30,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 226, 194, 114),
          Color.fromARGB(255, 236, 169, 162),
        ], stops: [
          0.5,
          1.0
        ]),
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(
            Icons.man_outlined,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                'Welcome To Mezenagna Restaurant ${user.firstName} Enjoy ',
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 74, 0, 248)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 5,
              top: 2,
            ),
          ),
        ],
      ),
    );
  }
}
