import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> checkUserLoggedIn() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setUser(currentUser);
    }
  }
}
