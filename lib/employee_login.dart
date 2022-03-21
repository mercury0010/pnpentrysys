import 'dart:html';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:pnpvehicleentry/dashboard.dart';
import 'loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'auth/authenticator.dart';
import 'auth/RegPersonnel.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qr_scanner_web/qr_scanner_web.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = "", _password = "";
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.red, Colors.blueGrey],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Center(
          child: Container(
              height: MediaQuery.of(context).size.height * .60,
              width: MediaQuery.of(context).size.width * .60,
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 60),
                      //height: MediaQuery.of(context).size.height * .30,
                      width: MediaQuery.of(context).size.width * .30,

                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Enter Email',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blue),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        onChanged: (value) {
                          setState(() {
                            _email = value.trim();
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 15,
                        bottom: 20,
                      ),
                      //height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * .30,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Enter Password',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blue),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        onChanged: (value) {
                          setState(() {
                            _password = value.trim();
                          });
                        },
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .05,
                        width: MediaQuery.of(context).size.width * .10,
                        margin: EdgeInsets.only(right: 20),
                        child: ElevatedButton(
                            child: Text('Signin'),
                            onPressed: () {
                              auth
                                  .signInWithEmailAndPassword(
                                      email: _email, password: _password)
                                  .then((_) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => DashboardPage()));
                              });
                            }),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .05,
                        width: MediaQuery.of(context).size.width * .10,
                        margin: EdgeInsets.only(left: 30),
                        child: ElevatedButton(
                          child: const Text('Signup'),
                          onPressed: () async {
                            if (_email == "" && _password == "") {
                              showAlertDialog(context);
                            } else {
                              auth
                                  .createUserWithEmailAndPassword(
                                      email: _email, password: _password)
                                  .then((_) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              });
                            }
                          },
                        ),
                      ),
                    ])
                  ],
                ),
              ))),
    ));
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () => Navigator.pop(context),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("TextFields can't be empty"),
    content: Text("empty dumpty."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
