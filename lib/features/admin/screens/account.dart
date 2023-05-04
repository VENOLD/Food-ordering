import 'package:flutter/material.dart';
import 'package:insa_cafeteria/features/account/widgets/account_button.dart';
import 'package:insa_cafeteria/features/admin/screens/add_admin_screen.dart';
import 'package:insa_cafeteria/features/admin/screens/services/admin_services.dart';

class Account extends StatefulWidget {
  static const String routeName = '/admin_account';
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'LogOut',
              onTap: () => AdminServices().logOUtt(context),
            ),
            AccountButton(
              text: 'Add Cashier',
              onTap: () => Navigator.pushNamed(context, Bose.routeName),
            ),
          ],
        ),
      ],
    );
  }
}
