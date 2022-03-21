import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Register Form';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String name = "",
        plate = "",
        id = "",
        qrcode = "",
        regDate = "",
        typeCar = "";

    final auth = FirebaseAuth.instance;

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Name',
              labelText: 'Name',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter ID #',
              labelText: 'ID #',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Plate #',
              labelText: 'Plate #',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Type of Vehicle',
              labelText: 'Type of Vehicle',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Date',
              labelText: 'Date of Registration',
            ),
          ),
          new Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: new ElevatedButton(
                child: const Text('Submit'),
                onPressed: null,
              )),
        ],
      ),
    );
  }
}
