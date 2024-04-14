import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:star_lateks/view/home/screens/landing_screen.dart.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithEmail(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      AppAlert.showWrongSnackbar(context, 'Please fill all fields');
      return;
    } else {
      try {
        _isLoading = true;
        notifyListeners();
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        User? user = result.user;
        if (user != null) {
          // ignore: use_build_context_synchronously
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LandingScreen()));
          _isLoading = false;
          notifyListeners();
        }
      } catch (error) {
        _isLoading = false;
        notifyListeners();

        log(error.toString());
      }
    }
  }
}
