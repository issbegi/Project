import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:urbanfootprint/view/intropages/splashscreen.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late Rx<User?> _user;

  @override
  void onInit() {
    super.onInit();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.authStateChanges());
  }

  // Register user with email and password
  Future<void> signup(String email, String password, String firstName,
      String lastName, String mobile) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString());
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    }
  }

  // Sign in user with email and password
  Future<void> signin(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString());
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    }
  }

  // Sign out user
  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAll(() =>  SplashScreen());
  }
}
