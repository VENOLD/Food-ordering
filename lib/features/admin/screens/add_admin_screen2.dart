import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/custom_button.dart';
import 'package:insa_cafeteria/common/widgets/custom_textfield.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/features/admin/screens/services/admin_services.dart';
import 'package:insa_cafeteria/features/auth/services/auth_service.dart';

class AddAdmin extends StatefulWidget {
  static const String routeName = '/add-admin';
  const AddAdmin({Key? key}) : super(key: key);

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  void signUpAdmin() {
    authService.signUpadmin(
      context: context,
      phoneNumber: _phoneController.text,
      name: _nameController.text,
      password: _passwordController.text,
    );
  }

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 203, 57, 46),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
          ],
        ),
      ),
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
                  controller: _nameController,
                  hintText: 'Name',
                ),
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
                    text: 'Add Cashier ',
                    color: const Color.fromARGB(255, 161, 131, 131),
                    onTap: () {
                      if (_signUpFormKey.currentState!.validate()) {
                        signUpAdmin();
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
