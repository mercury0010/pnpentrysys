import 'package:flutter/material.dart';

import 'main.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'auth/authenticator.dart';
import 'auth/RegPersonnel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'auth/authenticator.dart';

import 'package:firebase_core/firebase_core.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Lato',
          accentColor: Colors.blue,
          primaryColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        //use MaterialApp() widget like this
        home: Home() //create new widget class for this 'home' to
        // escape 'No MediaQuery widget found' error
        );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final AudioCache _audioCache;

  @override
  void initState() {
    super.initState();
    // create this only once
    _audioCache = AudioCache(
        prefix: "audio/",
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
  }

  @override
  Widget build(BuildContext context) {
    String _email = "", _password = "";
    final auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding:
            EdgeInsets.only(top: 60.0, bottom: 60.0, left: 120.0, right: 120.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          elevation: 5.0,
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3.3,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.yellow[600],
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 70.0, right: 50.0, left: 50.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: CircleAvatar(
                              backgroundColor: Colors.black87,
                              backgroundImage: NetworkImage(
                                'https://jideguru.github.io/static/img/profile.png',
                              ),
                              radius: 70.0,
                            ),
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: Text(
                              "Let's get you set up",
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: Text(
                              "It should only take a couple of minutes to pair with your watch",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          Container(
                            child: CircleAvatar(
                              backgroundColor: Colors.black87,
                              child: Text(
                                ">",
                                style: TextStyle(color: Colors.yellow),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 40.0, right: 70.0, left: 70.0, bottom: 40.0),
                  child: Column(
                    children: <Widget>[
                      //InputField Widget from the widgets folder
                      TextField(),

                      SizedBox(height: 20.0),

                      //Gender Widget from the widgets folder
                      //Gender(),

                      SizedBox(height: 20.0),

                      //InputField Widget from the widgets folder
                      TextField(),

                      SizedBox(height: 20.0),

                      //InputField Widget from the widgets folder

                      TextField(
                        decoration: InputDecoration(hintText: 'Email'),
                        onChanged: (value) {
                          setState(() {
                            _email = value.trim();
                          });
                        },
                      ),

                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'Password'),
                        onChanged: (value) {
                          setState(() {
                            _password = value.trim();
                          });
                        },
                      ),

                      SizedBox(height: 20.0),

                      TextField(),

                      SizedBox(height: 20.0),

                      //InputField Widget from the widgets folder
                      TextField(),

                      SizedBox(
                        height: 40.0,
                      ),

                      //Membership Widget from the widgets folder
                      //Membership(),

                      SizedBox(
                        height: 40.0,
                      ),

                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 170.0,
                          ),
                          FlatButton(
                            color: Colors.grey[200],
                            onPressed: () {},
                            child: Text("Cancel"),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          TextButton(
                            child: Text('Signin'),
                            onPressed: () async {
                              auth
                                  .signInWithEmailAndPassword(
                                      email: _email, password: _password)
                                  .then((_) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
