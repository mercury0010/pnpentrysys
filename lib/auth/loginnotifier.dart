import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'authenticator.dart';
// ignore: unused_import
import 'firebase_authentication.dart';

class SignInViewModel extends ChangeNotifier {
  SignInViewModel(this.locator);

  final Locator locator;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loginWithGoogle() async {
    _setLoading();
    await locator<Authentication>().loginWithGoogle();
    _setNotLoading();
  }

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _setNotLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
