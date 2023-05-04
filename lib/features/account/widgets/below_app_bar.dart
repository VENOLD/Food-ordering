import 'package:flutter/material.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 186, 186, 186),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          RichText(
              text: TextSpan(
                  text: 'Hello  ',
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                  children: [
                TextSpan(
                  text: user.firstName,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
