import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  

  Future<bool> signup(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Save additional user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      });

      return true; // User creation successful
    } catch (e) {
      print(e);
      return false; // User creation failed
    }
  }
}

