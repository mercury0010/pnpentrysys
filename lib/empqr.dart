import 'package:flutter/material.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(empqr(
    qrtext: '',
  ));
}

class empqr extends StatelessWidget {
  String qrtext = "";
  final QRsave = QrValidator();
  empqr({Key? key, required this.qrtext}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        height: 200,
        width: 200,
        child: QrImage(
          data: qrtext,
          size: 20,
        ),
      ),
    );
  }
}
