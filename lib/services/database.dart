import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/User.dart';

class DatabaseService {
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future<void> setUserData(User toUpload) async {
    print('Uploading user data 1234');
    print(toUpload.userName);
    print(toUpload.userEmail);

    await usersCollection.document(toUpload.userID).setData({
      'userEmail': toUpload.userEmail,
      'userName': toUpload.userName,
      'userRole': 'C',
      'userID': toUpload.userID,
    });
  }
}
