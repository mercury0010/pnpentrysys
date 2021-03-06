import 'dart:html';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:pnpvehicleentry/WelcomePage.dart';
import 'package:pnpvehicleentry/auth/population.dart';
import 'loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'auth/authenticator.dart';
import 'auth/RegPersonnel.dart';
import 'loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'WelcomePage.dart';
import 'employee_login.dart';
import 'home.dart';
import 'auth/addGuest.dart';
import 'auth/Guest.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(providers: [
      Provider<Authentication>(
        create: (_) => Authentication(),
      ),
      StreamProvider(
        create: (context) => context.read<Authentication>().getUser,
        initialData: register_personnel(),
      ),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "PNPPRO 11",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<register_personnel>(
          builder: (context, user, _) {
            if (user.uid == "") {
              return LoginPage();
            } else {
              return HomePage();
            }
          },
        ));
  }
}
