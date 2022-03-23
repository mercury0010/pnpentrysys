import 'dart:html';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:pnpvehicleentry/RegisterFormnew.dart';
import 'loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'auth/authenticator.dart';
import 'auth/RegPersonnel.dart';
import 'employee_login.dart';
import 'guest_login.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "", _password = "";
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: MediaQuery.of(context).size.height * .80,
        width: MediaQuery.of(context).size.width * .80,
        child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
                child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.red, Colors.blue],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .17,
                        width: MediaQuery.of(context).size.width * .15,
                        child: Image.asset(
                          'images/pnp.png',
                          //fit: BoxFit.fill,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text("PHILIPPINE NATIONAL POLICE",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                            color: Colors.red,
                          ))),
                  Container(
                    child: Text(
                      "VEHICLE ENTRY QR",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * .05,
                            width: MediaQuery.of(context).size.width * .10,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              child: const Text('Employee'),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                              },
                            )),
                        Container(
                            height: MediaQuery.of(context).size.height * .05,
                            width: MediaQuery.of(context).size.width * .10,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              child: const Text('Guest'),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => GuestLoginScreen()));
                              },
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ))),
      ),
    ));
  }
}
