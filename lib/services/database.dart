import 'package:carrental/models/Car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/User.dart';

class DatabaseService {
  // This is to set data in user db
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  // this is for cars:
  final CollectionReference carsCollection =
      Firestore.instance.collection('cars');

  Future<void> setUserData(User toUpload) async {
    await usersCollection.document(toUpload.userID).setData({
      'userEmail': toUpload.userEmail,
      'userName': toUpload.userName,
      'userRole': 'C',
      'userID': toUpload.userID,
    });
  }

  List<Car> carsList = [];

  Future<List<Car>> getCarsData() async {
    print(' in Future<List<Car>> getCarsData()');
    final result = await carsCollection.getDocuments();
    result.documents.map((e) {
      Car temp = Car(
          carID: e.documentID,
          carName: e.data['carName'],
          carType: e.data['carType'],
          carEngine: e.data['carEngine'],
          carRate: e.data['carRate'],
          carImage: e.data['carImage'],
          carMake: e.data['carMake']);
      carsList.add(temp);
    }).toList();
    return carsList;
  }
}
