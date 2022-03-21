import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

Future deleteData() async {
  DateTime dateToday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var DateYesterday = DateTime.now().subtract(Duration(days: 1));
  /*final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('vehiclepop');
  if (DateTime.now().toString() == DateTime.now().toString()) {
    _collectionReference.snapshots().forEach((element) {
      for (QueryDocumentSnapshot snapshot in element.docs) {
        snapshot.reference.delete();
      }
    });
    return null;
  } else {}
  return null;*/
  if (DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(Duration(days: 1))
          .toString() ==
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .toString()) {
    final DocumentReference docRef = FirebaseFirestore.instance
        .collection("vehiclepop")
        .doc("FasHtoBch9eiIVi6nYK0");
    docRef.update({
      "current": 0,
      "exited": 0,
      "entered": 0,
    });

    return print(docRef);
  } else {}
}
