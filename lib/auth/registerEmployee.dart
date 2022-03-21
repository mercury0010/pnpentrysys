import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:pnpvehicleentry/auth/employeeqr.dart';

import 'package:firebase/firebase.dart' as fb;
import 'Guest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'regEmployee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'employeeqr.dart';

class EmployeeService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String ids = "FasHtoBch9eiIVi6nYK0";
  final CollectionReference employees =
      FirebaseFirestore.instance.collection('personnel');
  final CollectionReference currentuid =
      FirebaseFirestore.instance.collection('personnel');

  Future<DocumentReference<Object?>> createEmployee(EmpData employee) async {
    Map<String, dynamic> data = {
      "currid": auth.currentUser!.uid,
      "Name": employee.name,
      "id": employee.idEmp,
      "plate": employee.plate,
      "qrcode": employee.qrcode,
      "regDate": employee.regDate,
      "type": employee.type,
    };
    var ref = await employees.add(data);
    print(ref);
    return ref;
  }

  Stream<List<eqr>> getItems() {
    return currentuid.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return eqr(
          uid: doc.get('currid').data(),
          qr: doc.get('qrcode'),
        );
      }).toList();
    });
  }

  uploadToFirebase(File file) async {
    final filePath = 'temp/${DateTime.now()}.png'; //path to save Storage
    try {
      fb.storage().refFromURL('urlFromStorage').child(filePath).put(file);
    } catch (e) {
      print('error:$e');
    }
  }
}
