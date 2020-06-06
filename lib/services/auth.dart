import 'package:firebase_auth/firebase_auth.dart';
import '../models/User.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get the stream if the user is login or not.

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // the function which we will use to convert the user we got from firebase
  // to the user modal we created
  User _userFromFirebaseUser(FirebaseUser user) {
    if (user == null) {
      return null;
    } else {
      // change this user setting.
      return User();
    }
  }

  // Sign in with google
  // when user sign in the information of the user should also be fetched and
  // stored in Users object and that will be shared across the device.

  // Register with google
  // When user will register the information of the user should be stored in
  // database (firestore database) and the document id should be same as
  // the uid provided by the firebase auth.

}
