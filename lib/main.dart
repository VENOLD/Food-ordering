import 'package:flutter/material.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/features/admin/screens/admin_screen.dart';
import 'package:insa_cafeteria/features/auth/screens/SignUp.dart';
import 'package:insa_cafeteria/features/auth/services/auth_service.dart';
import 'package:insa_cafeteria/features/home/screens/cafe_choosing.dart';
import 'package:insa_cafeteria/providers/admin2_provider.dart';
import 'package:insa_cafeteria/providers/admin_provider.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:insa_cafeteria/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AdminProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => Admin2Provider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
    authService.getAdminData(context);
    authService.getAdminData2(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cafeteria',
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariable.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariable.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          useMaterial3: true, // can remove this line
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context).user.type == 'User'
                ? const CafeChoosing()
                : const AdminScreen()
            : const SignUp());
  }
}
