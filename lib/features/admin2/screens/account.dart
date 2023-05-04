import 'package:flutter/material.dart';
import 'package:insa_cafeteria/features/account/widgets/account_button.dart';
import 'package:insa_cafeteria/features/admin/screens/add_admin_screen.dart';
import 'package:insa_cafeteria/features/admin/screens/services/admin_services.dart';
import 'package:insa_cafeteria/features/admin2/screens/services/admin_services.dart';

class AccountGojo extends StatefulWidget {
  static const String routeName = '/admin_account_admin';
  const AccountGojo({Key? key}) : super(key: key);

  @override
  State<AccountGojo> createState() => _AccountGojoState();
}

class _AccountGojoState extends State<AccountGojo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'log out',
              onTap: () => Admin2Services().logOUtt(context),
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
