import 'package:flutter/material.dart';
import 'package:insa_cafeteria/constants/util2.dart';

class Cafe3 extends StatefulWidget {
  const Cafe3({Key? key}) : super(key: key);

  @override
  State<Cafe3> createState() => _Cafe3State();
}

class _Cafe3State extends State<Cafe3> {
  @override
  Widget build(BuildContext context) {
    Size size = Util(context).getScreenSize;
    return Material(
      borderRadius: BorderRadius.circular(1),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1514933651103-005eec06c04b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fHJlc3RhdXJhbnR8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60',
                  width: size.width * 0.22,
                  height: size.height * 0.09,
                ),
                const SizedBox(width: 17),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Coming Soon",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [Text('Boom')],
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
