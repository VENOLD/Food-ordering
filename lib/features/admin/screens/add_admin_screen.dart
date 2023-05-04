import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/custom_button.dart';
import 'package:insa_cafeteria/common/widgets/custom_textfield.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/features/admin/screens/add_admin_screen2.dart';
import 'package:insa_cafeteria/features/admin/screens/services/admin_services.dart';

class Bose extends StatefulWidget {
  static const String routeName = '/Bose';
  const Bose({Key? key}) : super(key: key);

  @override
  State<Bose> createState() => _BoseState();
}

class _BoseState extends State<Bose> {
  final _signUpFormKey = GlobalKey<FormState>();

  final AdminServices adminServices = AdminServices();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void signInBose() {
    adminServices.signInBose(
      context: context,
      phoneNumber: _phoneController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 191, 38, 38),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/Gojo_logo.png',
                width: 120,
                height: 45,
              ),
            ),
            const Text(
              'Owner',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            )
          ])),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          color: GlobalVariable.backgroundColor,
          child: Form(
            key: _signUpFormKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _phoneController,
                  hintText: 'Phone Number',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'password',
                ),
                const SizedBox(height: 10),
                CustomButton(
                    text: 'Log In ',
                    color: const Color.fromARGB(255, 161, 131, 131),
                    onTap: () {
                      if (_signUpFormKey.currentState!.validate()) {
                        signInBose();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
