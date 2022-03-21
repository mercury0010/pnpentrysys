import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'RegPersonnel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Guest.dart';

class Authentication {
  register_personnel RegisterPer;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  final CollectionReference regUsers =
      FirebaseFirestore.instance.collection('personnel');

  Authentication({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
    register_personnel? registerUser,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        RegisterPer = registerUser ?? register_personnel();

  set currentUser(register_personnel currentUser) {}

  register_personnel userFromFirebaseUser(User user) {
    return register_personnel(
      uid: user.uid,
      perName: user.displayName ?? " ",
      email: user.email ?? "",
      display: false,
    );
  }

  Stream<register_personnel> get getUser {
    return _auth.authStateChanges().map((user) {
      return userFromFirebaseUser(user!);
    }).handleError((error) {
      return register_personnel();
    });
  }

  Future loginWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthhentication =
          await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthhentication.idToken,
        accessToken: googleSignInAuthhentication.accessToken,
      );
      UserCredential result = await _auth.signInWithCredential(credential);

      final User? user = result.user;
      final User? currentUser = _auth.currentUser;
      assert(user!.uid == currentUser!.uid);
      register_personnel loginUser = register_personnel();
      loginUser = userFromFirebaseUser(user!);

      DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection("personnel")
          .doc(loginUser.uid)
          .get();
      if (ds.exists) {
        loginUser.display = ds["display"];
      } else {
        FirebaseFirestore.instance
            .collection("personnel")
            .doc("loginUser.uid")
            .set({
          "display": true,
          "pername": loginUser.perName,
          "email": loginUser.email,
          "display": true,
        });
      }
      print("Tuara" + loginUser.perName);
      this.RegisterPer = loginUser;

      return loginUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future loginWithFacebook() async {}

  //createUserWithEmailAndPassword({String email, String password}) {}

}

Future<String> signup({required String email, required String password}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return "Signed UP";
  } on FirebaseAuthException catch (e) {
    return "yawa";
  }
}

Future signIn({required String email, required String password}) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return null;
  } on FirebaseAuthException catch (e) {
    return e.message;
  }
}

Future signOut() async {
  await FirebaseAuth.instance.signOut();

  print("signout");
}
