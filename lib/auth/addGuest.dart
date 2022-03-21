import 'Guest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'population.dart';

class GuestService {
  String ids = "FasHtoBch9eiIVi6nYK0";
  final CollectionReference guests =
      FirebaseFirestore.instance.collection('guest');

  final CollectionReference currentV =
      FirebaseFirestore.instance.collection('vehiclepop');
  Future<DocumentReference<Object?>> createGuest(GuestData guest) async {
    Map<String, dynamic> data = {
      "QRcode": guest.QRcode,
      "email": guest.email,
      "name": guest.name,
      "plate": guest.plate,
    };
    var ref = await guests.add(data);
    print(ref);
    return ref;
  }

  Stream<List<GuestData>> getGuest() {
    return guests.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return GuestData(
          QRcode: doc.get('QRcode'),
          email: doc.get('email'),
          name: doc.get('name'),
          plate: doc.get('plate'),
        );
      }).toList();
    });
  }

  Stream<List<pop>> getItems() {
    return currentV.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return pop(
          id: doc.id,
          current: doc.get('current'),
        );
      }).toList();
    });
  }
}
