import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/User.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // database collection reference to get users data
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  // get the stream if the user is login or not.
  Stream<User> get user {
    print('Looking for User');
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // the function which we will use to convert the user we got from firebase
  // to the user modal we created
  User _userFromFirebaseUser(FirebaseUser user) {
    if (user == null) {
      return null;
    } else {
      // change this user setting
      User toReturn = User(
        userID: user.uid,
        userEmail: null,
        userRole: null,
        userName: null,
      );
      return toReturn;
    }
  }

  // Sign in with email password
  // when user sign in the information of the user should also be fetched and
  // stored in Users object and that will be shared across the device.
  Future<User> signInUserWithEmailPassword(
      {String email, String password}) async {
    try {
      final AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser userToReturn = result.user;
      return _userFromFirebaseUser(userToReturn);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email password
  // When user will register the information of the user should be stored in
  // database (firestore database) and the document id should be same as
  // the uid provided by the firebase auth.

  Future<User> registerUserWithEmailPassword(
      User toRegister, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: toRegister.userEmail, password: password);
      FirebaseUser resultUser = result.user;
      return _userFromFirebaseUser(resultUser);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //SignOut the user

  void signOutUser() {
    _auth.signOut();
  }
}
