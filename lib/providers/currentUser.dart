import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/User.dart';

class CurrentUser with ChangeNotifier {
  User activeUser;

  // database collection reference to get users data
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future<void> setActiveUser(User toSet) async {
    // this function will get data like userID from the auth.dart file and
    // will set active user.
    final result = await usersCollection.document(toSet.userID).get();

    activeUser = User(
      userID: result.documentID,
      userName: result.data['userName'],
      userRole: result.data['userRole'],
      userEmail: result.data['userEmail'],
    );
  }

  User getActiveUser() {
    return activeUser;
  }
}
