import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/custom_button.dart';
import 'package:insa_cafeteria/common/widgets/custom_textfield.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/features/auth/screens/SignIn.dart';
import 'package:insa_cafeteria/features/auth/services/auth_service.dart';

enum Auth {
  signin,
  signup,
}

class ForgotPassword extends StatefulWidget {
  static const String routeName = '/forgot-password';
  const ForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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

  void signInAdmin() {
    authService.signInAdmin(
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
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _phoneController,
                          hintText: 'Phone Number',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                            text: 'Update Password',
                            color: Colors.orange,
                            onTap: () {}),
                        TextButton(
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                context, SignIn.routeName, (route) => false),
                            child: const Text('Back To login'))
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
