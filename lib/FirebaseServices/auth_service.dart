import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pingolearn_ecommerce_app/Providers/users.dart';
import 'package:provider/provider.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<Map<bool, String>> registerUser(
      {required String email,
      required String password,
      required String name}) async {
    Map<bool, String> response = <bool, String>{};
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        response[true] = "Success";
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'name': name,
        });
      } else {
        response[false] = "Internal Server Error!!";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        response[false] = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        response[false] = 'The account already exists for that email.';
      } else {
        response[false] = e.toString();
      }
    } catch (e) {
      response[false] = e.toString();
    }
    return response;
  }

  static Future<Map<bool, String>> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    Map<bool, String> response = <bool, String>{};
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        response[true] = "Success";
        Provider.of<UserProvider>(context, listen: false).setUser(user);
      } else {
        response[false] = "Internal Server Error";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        response[false] = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        response[false] = 'Wrong password provided for that user.';
      } else {
        response[false] = e.toString();
      }
    } catch (e) {

      response[false] = e.toString();
    }
    return response;
  }

  static Future<bool> signOut(BuildContext context) async {
   try {
 await _auth.signOut();
    Provider.of<UserProvider>(context, listen: false).setUser(null);
    return true;
   } catch(e) {
    return false;
   }
   
  }
}
