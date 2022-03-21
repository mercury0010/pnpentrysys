import 'dart:html';
import 'dart:js';
import 'dart:io' show File;
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pnpvehicleentry/auth/registerEmployee.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'auth/authenticator.dart';
import 'auth/RegPersonnel.dart';
import 'auth/authenticator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/Guest.dart';
import 'auth/addGuest.dart';
import 'generatedqr.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:firebase_storage/firebase_storage.dart' as _firebaseStorage;
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:path/path.dart' as Path;
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class Todo {
  final String qrcode;

  const Todo(this.qrcode);
}

class GuestLoginScreen extends StatefulWidget {
  @override
  _GuestLoginScreenState createState() => _GuestLoginScreenState();
}

class _GuestLoginScreenState extends State<GuestLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = "", _name = "", plate = "";
  final picker = ImagePicker();
  final auth = FirebaseAuth.instance;
  List<Widget> itemPhotosWidgetList = <Widget>[];

  final ImagePicker _picker = ImagePicker();
  io.File? file;
  List<XFile>? photo = <XFile>[];
  List<XFile> itemImagesList = <XFile>[];

  List<String> downloadUrl = <String>[];

  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    String QRcodeRes = _name + plate;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.red, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Center(
        child: Container(
            height: MediaQuery.of(context).size.height * .90,
            width: MediaQuery.of(context).size.width * .60,
            child: Card(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .30,
                    padding: const EdgeInsets.only(
                      top: 50.0,
                      bottom: 8.0,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: 'Enter Email',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .30,
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          hintText: 'Name',
                          labelText: 'Enter Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onChanged: (value) {
                        _name = value;
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .30,
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          hintText: 'License Plate',
                          labelText: 'Enter License Plate',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onChanged: (value) {
                        plate = value;
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .30,
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          hintText: 'LTO no.',
                          labelText: 'LTO id number',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onChanged: (value) {
                        //_name = value;
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .30,
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          hintText: 'Purpose',
                          labelText: 'Purpose',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onChanged: (value) {
                        //_name = value;
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .30,
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          hintText: 'ORCR',
                          labelText: 'ORCR',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onChanged: (value) {
                        //_name = value;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: itemPhotosWidgetList.isEmpty
                            ? Center(
                                child: MaterialButton(
                                  onPressed: pickPhotoFromGallery,
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Center(
                                      child: Image.network(
                                        "https://static.thenounproject.com/png/3322766-200.png",
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .10,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .10,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Wrap(
                                  spacing: 5.0,
                                  direction: Axis.horizontal,
                                  children: itemPhotosWidgetList,
                                  alignment: WrapAlignment.spaceEvenly,
                                  runSpacing: 10.0,
                                ),
                              ),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * .05,
                            width: MediaQuery.of(context).size.width * .10,
                            child: ElevatedButton(
                              child: const Text('Register'),
                              onPressed: () async {
                                uploading ? null : () => upload();
                                await GuestService()
                                    .createGuest(GuestData(
                                      QRcode: "pnpguest" + _name + plate,
                                      email: _email,
                                      name: _name,
                                      plate: plate,
                                    ))
                                    .then((value) => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => GuestQR(
                                                  qrtext: "pnpguest" +
                                                      _name +
                                                      plate,
                                                ))));
                              },
                            ))
                      ]),
                ],
              ),
            )),
      ),
    ));
  }

  addImage() {
    for (var bytes in photo!) {
      itemPhotosWidgetList.add(Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          height: 90.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              child: kIsWeb
                  ? Image.network(io.File(bytes.path).path)
                  : Image.file(
                      io.File(bytes.path),
                    ),
            ),
          ),
        ),
      ));
    }
  }

  pickPhotoFromGallery() async {
    photo = await _picker.pickMultiImage();
    if (photo != null) {
      setState(() {
        itemImagesList = itemImagesList + photo!;
        addImage();
        photo!.clear();
      });
    }
  }

  upload() async {
    String productId = await uplaodImageAndSaveItemInfo();
    setState(() {
      uploading = false;
    });
  }

  Future<String> uplaodImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });
    PickedFile? pickedFile;
    String? productId = const Uuid().v4();
    for (int i = 0; i < itemImagesList.length; i++) {
      file = io.File(itemImagesList[i].path);
      pickedFile = PickedFile(file!.path);

      await uploadImageToStorage(pickedFile, productId);
    }
    return productId;
  }

  uploadImageToStorage(PickedFile? pickedFile, String productId) async {
    String? pId = const Uuid().v4();
    Reference reference =
        FirebaseStorage.instance.ref().child('Items/$productId/product_$pId');

    await reference.putData(
      await pickedFile!.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );
    String value = await reference.getDownloadURL();
    downloadUrl.add(value);
  }
}
