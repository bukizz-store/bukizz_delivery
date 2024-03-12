import 'dart:convert';
import 'package:bukizz_delivery/constants/strings.dart';
import 'package:bukizz_delivery/mvvm/views/NavBar/NavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/colors.dart';
import '../../../constants/constants.dart';
import '../../models/userModel/userModel.dart';
import '../../views/Auth/Login/Signin_Screen.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      print("hash Password ${UserModel.hashPassword(password)}");
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("uid ${authResult.user!.uid}");

      UserModel userDetails = UserModel(
        id: authResult.user!.uid,
        name: '',
        email: email,
        password: UserModel.hashPassword(password),
        phone: '',
        delivered: [],
        pendingDelivery: [],
      );

      if (authResult.user!.uid.isNotEmpty) {
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection(AppString.collectionDelivery)
            .where('email', isEqualTo: email)
            .get();

        userDetails = UserModel.fromMap(querySnapshot.docs.first.data());

        AppConstants.userData = userDetails;
        AppConstants.isLogin = true;

        // print(userDetails);

        // // Push user data to Firebase
        await userDetails.pushToFirebase();

        await userDetails.saveToSharedPreferences();

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.route, (route) => false);
        }
      } else {
        if(context.mounted)
        {
          AppConstants.showSnackBar(context, "Failed to Login" , AppColors.error , Icons.error_outline_rounded,);
          Navigator.of(context).pop();
        }
      }
      notifyListeners();
    } catch (e) {
      // Handle sign-in errors
      String errorMessage = "An error occurred during sign-in.";

      if (e is FirebaseAuthException) {
        print(e.code);
        if (e.code == 'user-not-found') {
          errorMessage = "No user found with this email.";
        } else if (e.code == 'invalid-credential') {
          errorMessage = "Incorrect password.";
        } else {
          errorMessage = "Error: ${e.message}";
        }
      }

      if (context.mounted) {
        AppConstants.showSnackBar(context, errorMessage , AppColors.error , Icons.error_outline_rounded);
        Navigator.of(context).pop();
      }
      print("Error signing in: $e");
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // Hash the password using SHA-256
      String hashPassword(String password) {
        var bytes = utf8.encode(password);
        var digest = sha256.convert(bytes);
        return digest.toString();
      }

      // Create a Firebase user using email and password
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (authResult.user != null && authResult.user!.uid.isNotEmpty) {

        print(authResult.user!.uid);

        UserModel userDetails = UserModel(
          name: name,
          email: email,
          password: hashPassword(password),
          phone: '',
          delivered: [],
          pendingDelivery: [],
          id: authResult.user!.uid,
        );

        try {
          // Push user data to Firebase
          await userDetails.pushToFirebase();
          // Save user details to shared preferences
          await userDetails.saveToSharedPreferences();
        } catch (e) {
          print("Error due to $e");
        }

        // Navigate to the home screen
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.route, (route) => false);
        }

        notifyListeners();
      } else {
        AppConstants.showSnackBar(context, "Failed to SignUp" , AppColors.error , Icons.error_outline_rounded);
        Navigator.of(context).pop();
      }
    } catch (e) {
      String errorMessage = "An error occurred during sign-up.";

      if (e is FirebaseAuthException) {
        print(e.code);
        if (e.code == 'email-already-in-use') {
          errorMessage = "The email address is already in use.";
        } else {
          errorMessage = "Error: ${e.message}";
        }
      }

      if (context.mounted) {
        AppConstants.showSnackBar(context, errorMessage , AppColors.error , Icons.error_outline_rounded);
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    AppConstants.userData = UserModel(
      name: '',
      email: '',
      password: '',
      phone: '',
      delivered: [],
      pendingDelivery: [],
      id: '',
    );
    await _auth.signOut().then((value) => {
      Navigator.pushNamedAndRemoveUntil(
          context, SignIn.route, (route) => false)
    });
    notifyListeners();
  }
}
