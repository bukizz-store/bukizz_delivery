import 'dart:convert';
import 'dart:developer';
import 'package:bukizz_delivery/constants/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constants.dart';

class UserModel{
  late final String id;
  late final String name;
  late final String email;
  late final String password;
  late final List<String> delivered;
  late final List<String> pendingDelivery;
  late final String phone;

  UserModel({required this.id, required this.name, required this.email, required this.delivered , required this.pendingDelivery, required this.password, required this.phone});

  UserModel.fromJson(Map<String, dynamic> json, this.id, this.name, this.email, this.password, this.phone){
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    delivered = json['delivered'].cast<String>() ?? [];
    pendingDelivery = json['pendingDelivery'].cast<String>() ?? [];
    phone = json['phone'] ?? '';
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['delivered'] = delivered;
    data['pendingDelivery'] = pendingDelivery;
    data['phone'] = phone;
    return data;
  }

  //fromSnapshot
  UserModel.fromSnapshot(Map<String, dynamic> snapshot){
    id = snapshot['id'];
    name = snapshot['name'];
    email = snapshot['email'];
    password = snapshot['password'];
    delivered = snapshot['delivered'].cast<String>();
    pendingDelivery = snapshot['pendingDelivery'].cast<String>();
    phone = snapshot['phone'];
  }

  // Hash the password using SHA-256
  static String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  //fromMap
  UserModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    name = map['name'];
    email = map['email'];
    password = map['password'];
    delivered = map['delivered'].cast<String>();
    pendingDelivery = map['pendingDelivery'].cast<String>();
    phone = map['phone'];
  }

  //toMap
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'delivered': delivered,
      'pendingDelivery': pendingDelivery,
      'phone': phone,
    };
  }

  Future<void> pushToFirebase() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection(AppString.collectionDelivery)
          .where('email', isEqualTo: email)
          .get();

      var fire = FirebaseDatabase.instance.ref().child('token').child(id);
      await fire.set({'token': AppConstants.fcmToken});

      if (querySnapshot.docs.isEmpty) {
        // If no document with the same email exists, add a new document
        await FirebaseFirestore.instance.collection(AppString.collectionDelivery).doc(id).set(toMap());

      } else {
        // If a document with the same email exists, you may choose to handle this case accordingly
        log('User with email $email already exists in Firestore');
      }
      AppConstants.userData = UserModel.fromMap(toMap());

    } catch (e) {
      print('Error pushing user data to Firebase: $e');
    }

  }

  // Save user details to shared preferences
  Future<void> saveToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', jsonEncode(AppConstants.userData.toJson()));
    prefs.setBool('isLogin', true);
  }

  // Load user details from shared preferences
  static Future<UserModel> loadFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData') ?? '';

    // print(AppConstants.locationSet);
    bool? isLogin = prefs.getBool('isLogin') ?? false;

    if (userData != '') {
      Map<String, dynamic> map = jsonDecode(userData);
      AppConstants.isLogin = isLogin;
      AppConstants.userData = UserModel.fromMap(map);
      return UserModel.fromMap(map);
    }

    return UserModel(id: '', name: '', email: '', delivered: [], pendingDelivery: [], password: '', phone: '');
  }

}