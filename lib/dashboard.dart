import 'package:flutter/material.dart';
import 'auth/population.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int i = 220;
  String? _timeString;

  @override
  Widget build(BuildContext context) {
    // String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    // print(cdate);
    // String tdata = DateFormat("HH:mm:ss a").format(DateTime.now());
    // print(tdata);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          )),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.red,
                Colors.blueGrey,
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day)
                    .subtract(Duration(days: 1))
                    .toString(),
                style: TextStyle(
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 100),
                      width: 220,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('vehiclepop')
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasError)
                            return Text('Error = ${snapshot.error}');

                          if (snapshot.hasData) {
                            final docs = snapshot.data!.docs;
                            return ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: (_, i) {
                                final data = docs[i].data();
                                return ListTile(
                                  title: Text(
                                    "Vehicles Entered: \n" +
                                        data['entered'].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                );
                              },
                            );
                          }

                          return Center(child: CircularProgressIndicator());
                        },
                      )),
                  Container(
                      padding: EdgeInsets.only(
                        top: 100,
                      ),
                      width: 220,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('vehiclepop')
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasError)
                            return Text('Error = ${snapshot.error}');

                          if (snapshot.hasData) {
                            final docs = snapshot.data!.docs;
                            return ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: (_, i) {
                                final data = docs[i].data();
                                return ListTile(
                                  title: Text(
                                    "Vehicles currently parking: \n" +
                                        data['current'].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              },
                            );
                          }

                          return Center(child: CircularProgressIndicator());
                        },
                      )),
                  Container(
                      padding: EdgeInsets.only(top: 100),
                      width: 220,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('vehiclepop')
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasError)
                            return Text('Error = ${snapshot.error}');

                          if (snapshot.hasData) {
                            final docs = snapshot.data!.docs;
                            return ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: (_, i) {
                                final data = docs[i].data();
                                return ListTile(
                                  title: Text(
                                    "Vehicles Exited: \n" +
                                        data['exited'].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                );
                              },
                            );
                          }

                          return Center(child: CircularProgressIndicator());
                        },
                      )),
                  Container(
                      padding: EdgeInsets.only(
                        top: 120,
                      ),
                      width: 220,
                      height: 360,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('vehiclepop')
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasError)
                            return Text('Error = ${snapshot.error}');

                          if (snapshot.hasData) {
                            final docs = snapshot.data!.docs;
                            return ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: (_, i) {
                                final data = docs[i].data();
                                return ListTile(
                                  title: Text(
                                    "Parking Slots Available: \n" +
                                        (220 - data['current']).toString() +
                                        '/220',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                );
                              },
                            );
                          }

                          return Center(child: CircularProgressIndicator());
                        },
                      )),
                ],
              ),
            ],
          )),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy \nhh:mm:ss').format(dateTime);
  }
}
