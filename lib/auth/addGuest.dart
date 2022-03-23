import 'Guest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'population.dart';

class GuestService {
  String ids = "FasHtoBch9eiIVi6nYK0";
  final CollectionReference guests =
      FirebaseFirestore.instance.collection('guest');

  final CollectionReference currentV =
      FirebaseFirestore.instance.collection('vehiclepop');
  //add Guest to the guest database
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
  //

}
