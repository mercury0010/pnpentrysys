import 'dart:async';
import 'package:cron/cron.dart';

import 'auth/reset.dart';
import 'package:flutter/material.dart';
import 'package:pnpvehicleentry/auth/authenticator.dart';
import 'package:pnpvehicleentry/auth/population.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'WelcomePage.dart';
import 'package:intl/intl.dart';
import 'dashboard.dart';
import 'profiling.dart';
import 'my_drawer_header.dart';
import 'settings.dart';
import 'privacy_policy.dart';
import 'send_feedback.dart';
import 'TimeLogs.dart';
import 'package:flutter/scheduler.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;
  String? _timeString;
  final cron = Cron();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) => deleteData());
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  int i = 220;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage();
    } else if (currentPage == DrawerSections.profiling) {
      container = profiling();
    } else if (currentPage == DrawerSections.TESTDATA) {
      container = TestData();
    } else if (currentPage == DrawerSections.settings) {
      container = SettingsPage();
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Vehicle Management Application"),
              Text(
                _timeString!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
      body: (container),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
                TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut().whenComplete(() {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                    });
                  },
                  child: Text("Log Out"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Profiling", Icons.people_alt_outlined,
              currentPage == DrawerSections.profiling ? true : false),
          menuItem(6, "Time Logs", Icons.people_alt_outlined,
              currentPage == DrawerSections.TESTDATA ? true : false),
          menuItem(3, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          Divider(),
          menuItem(4, "Privacy policy", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy ? true : false),
          menuItem(5, "Send feedback", Icons.feedback_outlined,
              currentPage == DrawerSections.send_feedback ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.profiling;
            } else if (id == 3) {
              currentPage = DrawerSections.settings;
            } else if (id == 4) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 5) {
              currentPage = DrawerSections.send_feedback;
            } else if (id == 6) {
              currentPage = DrawerSections.TESTDATA;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy \nhh:mm:ss').format(dateTime);
  }
}

enum DrawerSections {
  dashboard,
  profiling,
  settings,
  privacy_policy,
  send_feedback,
  TESTDATA,
}
