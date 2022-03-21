import 'package:flutter/material.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(GuestQR(
    qrtext: '',
  ));
}

class GuestQR extends StatelessWidget {
  String qrtext = "";
  final QRsave = QrValidator();
  GuestQR({Key? key, required this.qrtext}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .20,
          width: MediaQuery.of(context).size.width * .20,
          child: QrImage(
            data: qrtext,
            size: 30,
          ),
        ),
      ),
    );
  }
}
