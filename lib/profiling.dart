import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnpvehicleentry/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pnpvehicleentry/pages/RegisterForm.dart';
import 'RegisterFormnew.dart';
import 'package:provider/provider.dart';
import 'auth/Guest.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:firebase_core/firebase_core.dart';

class profiling extends StatefulWidget {
  @override
  _profiling createState() => _profiling();
}

class _profiling extends State<profiling> {
  bool isAscending = false;
  int sortColumnIndex = 0;
  @override
  Widget build(BuildContext) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(text: "Employee"),
                  Tab(text: "Guest"),
                ],
              ),
              backgroundColor: Colors.blueGrey,
            ),
            body: TabBarView(
              children: [
                ListView(children: <Widget>[
                  Container(
                      child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('personnel')
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError)
                        return Text('Error = ${snapshot.error}');
                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;
                        final dataName =
                            docs.map((data) => data['Name']).toList();
                        final dataPlate =
                            docs.map((data) => data['plate']).toList();
                        final dataDate =
                            docs.map((data) => data['regDate']).toList();
                        final dataQr =
                            docs.map((data) => data['qrcode']).toList();
                        return DataTable(
                            columns: [
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Plate')),
                              DataColumn(label: Text('Date Registered')),
                              DataColumn(label: Text('QRcode')),
                            ],
                            rows: List<DataRow>.generate(
                              dataName.length,
                              (index) => DataRow(cells: [
                                DataCell(Text(dataName[index])),
                                DataCell(Text(dataPlate[index])),
                                DataCell(Text(dataDate[index])),
                                DataCell(Text(dataQr[index]))
                              ]),
                            ));
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ))
                ]),
                ListView(children: <Widget>[
                  Container(
                      child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('guest')
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError)
                        return Text('Error = ${snapshot.error}');
                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;
                        final dataName =
                            docs.map((data) => data['name']).toList();
                        final dataPlate =
                            docs.map((data) => data['plate']).toList();
                        final dataDate =
                            docs.map((data) => data['email']).toList();
                        final dataQr =
                            docs.map((data) => data['QRcode']).toList();
                        return DataTable(
                            columns: [
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Plate #')),
                              DataColumn(label: Text('email')),
                              DataColumn(label: Text('QR code')),
                            ],
                            rows: List<DataRow>.generate(
                              dataName.length,
                              (index) => DataRow(cells: [
                                DataCell(Text(dataName[index])),
                                DataCell(Text(dataPlate[index])),
                                DataCell(Text(dataDate[index])),
                                DataCell(Text(dataQr[index]))
                              ]),
                            ));
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ))
                ]),
              ],
            )));
  }

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 'Name') {}
    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }
}
