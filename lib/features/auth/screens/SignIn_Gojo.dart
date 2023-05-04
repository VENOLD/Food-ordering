import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/custom_button.dart';
import 'package:insa_cafeteria/common/widgets/custom_textfield.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/features/auth/screens/SignIn.dart';
import 'package:insa_cafeteria/features/auth/screens/forgot_password.dart';
import 'package:insa_cafeteria/features/auth/services/auth_service.dart';

enum Auth {
  signin,
  signup,
}

class SignInAdminGojo extends StatefulWidget {
  static const String routeName = '/loginAdmin-screen';
  const SignInAdminGojo({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInAdminGojo> createState() => _SignInAdminGojoState();
}

class _SignInAdminGojoState extends State<SignInAdminGojo> {
  final _signInFormKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  void signInAdminGojo() {
    authService.signInAdmin2(
      context: context,
      phoneNumber: _phoneController.text,
      password: _passwordController.text,
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
                const SizedBox(height: 50),
                Image.asset(
                  'assets/images/gojo_logooo.png',
                  fit: BoxFit.contain,
                ),
                const Text(
                  ' Cashier ',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
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
                        const SizedBox(height: 20),
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
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'Enter password',
                              icon: Icon(Icons.password_outlined)),
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                            text: 'Sign In',
                            color: Colors.orange,
                            onTap: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signInAdminGojo();
                              }
                            }),
                        TextButton(
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                context,
                                ForgotPassword.routeName,
                                (route) => false),
                            child: const Text('Forgot Password?')),
                        TextButton(
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                context, SignIn.routeName, (route) => false),
                            child: const Text('Back To User log in'))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
