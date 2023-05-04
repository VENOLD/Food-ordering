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

class SignUp extends StatefulWidget {
  static const String routeName = '/SignUp-screen';
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signUpFormKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      phoneNumber: _phoneController.text,
      firstName: _fnameController.text,
      lastName: _lnameController.text,
      email: _emailController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/images/my_logo.png',
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                color: GlobalVariable.backgroundColor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Enter First Name',
                            icon: Icon(Icons.manage_accounts_outlined)),
                        controller: _fnameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter First Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Enter Last Name',
                            icon: Icon(Icons.manage_accounts_outlined)),
                        controller: _lnameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Last Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            labelText: 'Enter Email',
                            icon: Icon(Icons.email_outlined)),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                            return "Please Enter Correct Email Address";
                          } else {
                            return null;
                          }
                        },
                      ),
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
                      const SizedBox(height: 30),
                      CustomButton(
                          text: 'Sign Up ',
                          color: const Color.fromARGB(255, 188, 127, 37),
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Do you have an account?',
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      SignIn.routeName,
                    );
                  },
                  child: const Text(
                    'log in',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.normal),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
