import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:pnpvehicleentry/pages/RegisterForm.dart';
import 'RegisterFormnew.dart';
import 'package:provider/provider.dart';
import 'auth/Guest.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:firebase_core/firebase_core.dart';

class TestData extends StatefulWidget {
  @override
  _DataTable2 createState() => _DataTable2();
}

class _DataTable2 extends State<TestData> {
  @override
  Widget build(BuildContext context) {
    final String name;

    return MaterialApp(
        home: Scaffold(
      body: ListView(children: <Widget>[
        Center(
            child: Text('Time Logs',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('guestqr').snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasError) return Text('Error = ${snapshot.error}');

            if (snapshot.hasData) {
              final docs = snapshot.data!.docs;
              final date = docs.map((data) => data['datetime']).toList();
              final date1 = docs.map((data) => data['datetime']).toList();
              final qr = docs.map((data) => data['qrcode']).toList();
              final stat = docs.map((data) => data['state']).toList();
              int currentsort = 0;
              bool isAscending = true;
              return DataTable(
                  sortAscending: isAscending,
                  sortColumnIndex: currentsort,
                  columns: [
                    DataColumn(
                      label: Text('Date'),
                    ),
                    DataColumn(label: Text('QR code')),
                    DataColumn(
                      label: Text('Status'),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    date.length,
                    (index) => DataRow(cells: [
                      DataCell(Text(date[index])),
                      DataCell(Text(qr[index])),
                      DataCell(Text(stat[index]))
                    ]),
                  ).reversed.toList());
            }

            return Center(child: CircularProgressIndicator());
          },
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterFormnew()));
        },
        child: const Icon(Icons.add),
      ),
    ));
  }
}
