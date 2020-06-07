import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/User.dart';

class DatabaseService {
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future<void> setUserData(User toUpload) async {
    await usersCollection.document(toUpload.userID).setData({
      'userEmail': toUpload.userEmail,
      'userName': toUpload.userName,
      'userRole': 'C',
      'userID': toUpload.userID,
    });
  }
}
