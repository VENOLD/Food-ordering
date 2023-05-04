import 'package:flutter/material.dart';

class Sorry extends StatelessWidget {
  static const String routeName = '/sorry';
  const Sorry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50), child: AppBar()),
        body: SafeArea(
            child: Center(
                child: Column(children: [
          const SizedBox(height: 10),
          Icon(
            Icons.not_interested_rounded,
            size: 100,
          ),
          const SizedBox(height: 20),
          const Text(
            'You Are NOt Allowed To Access!!!!',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]))));
  }
}
