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

class TableDisplay extends StatefulWidget {
  @override
  _tabledisplay createState() => _tabledisplay();
}

class _tabledisplay extends State<TableDisplay> {
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
                  Center(
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
                  Center(
                      child: Text('Temporary Registered Vehicles',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold))),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('personnel')
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError)
                        return Text('Error = ${snapshot.error}');

                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;
                        final datas = docs.map((data) => data['Name']).toList();
                        final name = datas.toList();
                        return DataTable(
                            columns: [
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Plate')),
                              DataColumn(label: Text('QRcode')),
                            ],
                            rows: List<DataRow>.generate(
                              datas.length,
                              (index) => DataRow(cells: [
                                DataCell(Text(datas[index])),
                                DataCell(Text(datas[index])),
                                DataCell(Text(datas[index])),
                              ]),
                            ));

                        // ignore: dead_code

                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  )
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
