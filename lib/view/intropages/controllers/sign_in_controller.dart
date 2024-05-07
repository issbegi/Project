import 'package:get/get.dart';
import 'package:urbanfootprint/view/home/auth_repo.dart';

class LoginController extends GetxController {
  final AuthRepo _authRepo = AuthRepo.instance;

  Future<bool> signin(String email, String password) async {
    try {
      await _authRepo.signin(email, password);
      return true; // Return true if signin is successful
    } catch (e) {
      // Catch any errors and return false
      return false;
    }
  }
}
