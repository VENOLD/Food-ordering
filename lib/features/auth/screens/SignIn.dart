import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/custom_button.dart';
import 'package:insa_cafeteria/common/widgets/custom_textfield.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/features/auth/screens/SignIn_Gojo.dart';
import 'package:insa_cafeteria/features/auth/screens/signin_mezenagna_cashier.dart';
import 'package:insa_cafeteria/features/auth/services/auth_service.dart';

enum Auth {
  signin,
  signup,
}

class SignIn extends StatefulWidget {
  static const String routeName = '/login-screen';
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _signInFormKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();

  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      phoneNumber: _phoneController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          )),
      body: SafeArea(
        child: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                Image.asset(
                  'assets/images/my_logo.png',
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  color: GlobalVariable.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                              labelText: 'Enter Phone Number',
                              icon: Icon(Icons.phone_android_outlined)),
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                    .hasMatch(value)) {
                              //  r'^[0-9]{10}$' pattern plain match number with length 10
                              return "Please Enter Correct Phone Number";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                            text: 'Sign In',
                            color: const Color.fromARGB(255, 188, 127, 37),
                            onTap: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }
                            }),
                        const SizedBox(height: 60),
                        const SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          );
        }),
      ),
    );
  }
}
