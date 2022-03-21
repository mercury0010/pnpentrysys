import 'dart:html';

import 'package:flutter/material.dart';
import 'auth/registerEmployee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth/registerEmployee.dart';
import 'auth/regEmployee.dart';
import 'empqr.dart';

class RegisterFormnew extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String name = "",
      plate = "",
      id = "",
      qrcode = "",
      regDate = "",
      typeCar = "";

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Register Form';

    return DefaultTabController(
      length: 1,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Text(appTitle),
          ),
          body: Container(
            child: ListView(
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * .30,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Name',
                                labelText: 'Name',
                              ),
                              onChanged: (value) {
                                name = value;
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .30,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter ID #',
                                labelText: 'ID #',
                              ),
                              onChanged: (value) {
                                id = value;
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .30,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter Plate #',
                                labelText: 'Plate #',
                              ),
                              onChanged: (value) {
                                plate = value;
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .30,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter Type of Vehicle',
                                labelText: 'Type of Vehicle',
                              ),
                              onChanged: (value) {
                                typeCar = value;
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .30,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter Date',
                                labelText: 'Date of Registration',
                              ),
                              onChanged: (value) {
                                regDate = value;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 15),
                                  child: ElevatedButton(
                                      child: const Text('Submit'),
                                      onPressed: () async {
                                        await EmployeeService()
                                            .createEmployee(EmpData(
                                                name: name,
                                                idEmp: id,
                                                plate: plate,
                                                type: typeCar,
                                                regDate: regDate,
                                                qrcode: "pnpemployee" + id))
                                            .then((value) => Navigator.of(
                                                    context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) => empqr(
                                                          qrtext:
                                                              "pnpemployee" +
                                                                  id,
                                                        ))));
                                      }),
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 15),
                                    child: ElevatedButton(
                                        child: const Text('qr'),
                                        onPressed: () {})),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}

// // Create a Form widget.
// class MyCustomForm extends StatefulWidget {
//   @override
//   MyCustomFormState createState() {
//     return MyCustomFormState();
//   }
// }

// // Create a corresponding State class. This class holds data related to the form.
// class MyCustomFormState extends State<MyCustomForm> {
//   // Create a global key that uniquely identifies the Form widget
//   // and allows validation of the form.
//   final _formKey = GlobalKey<FormState>();
//   String name = "",
//       plate = "",
//       id = "",
//       qrcode = "",
//       regDate = "",
//       typeCar = "";

//   final auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     // Build a Form widget using the _formKey created above.
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           TextFormField(
//             decoration: const InputDecoration(
//               hintText: 'Name',
//               labelText: 'Name',
//             ),
//             onChanged: (value) {
//               name = value;
//             },
//           ),
//           TextFormField(
//             decoration: const InputDecoration(
//               hintText: 'Enter ID #',
//               labelText: 'ID #',
//             ),
//             onChanged: (value) {
//               id = value;
//             },
//           ),
//           TextFormField(
//             decoration: const InputDecoration(
//               hintText: 'Enter Plate #',
//               labelText: 'Plate #',
//             ),
//             onChanged: (value) {
//               plate = value;
//             },
//           ),
//           TextFormField(
//             decoration: const InputDecoration(
//               hintText: 'Enter Type of Vehicle',
//               labelText: 'Type of Vehicle',
//             ),
//             onChanged: (value) {
//               typeCar = value;
//             },
//           ),
//           TextFormField(
//             decoration: const InputDecoration(
//               hintText: 'Enter Date',
//               labelText: 'Date of Registration',
//             ),
//             onChanged: (value) {
//               regDate = value;
//             },
//           ),
//           Row(
//             children: [
//               ElevatedButton(
//                   child: const Text('Submit1'),
//                   onPressed: () async {
//                     await EmployeeService()
//                         .createEmployee(EmpData(
//                             name: name,
//                             idEmp: id,
//                             plate: plate,
//                             type: typeCar,
//                             regDate: regDate,
//                             qrcode: "pnpemployee" + plate + id))
//                         .then((value) =>
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => empqr(
//                                       qrtext: "pnpguest" + plate + id,
//                                     ))));
//                   })
//             ],
//           ),
//           Row(
//             children: [
//               ElevatedButton(child: const Text('qr'), onPressed: () {})
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
