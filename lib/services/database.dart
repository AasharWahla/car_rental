import 'package:carrental/models/Car.dart';
import 'package:carrental/models/Order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/User.dart';
import 'dart:async';

class DatabaseService {
  // This is to set data in user db
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  // this is for cars:
  final CollectionReference carsCollection =
      Firestore.instance.collection('cars');

  // this is for orders:
  final CollectionReference ordersCollection =
      Firestore.instance.collection('orders');

  Future<void> setUserData(User toUpload) async {
    await usersCollection.document(toUpload.userID).setData({
      'userEmail': toUpload.userEmail,
      'userName': toUpload.userName,
      'userRole': 'C',
      'userID': toUpload.userID,
    });
  }

  List<Order> ordersList = [];

  Future<List<Order>> getOrdersData() async {
    final result = await ordersCollection.getDocuments();
    result.documents.map((e) {
      Order temp = Order(
          oID: e.documentID,
          userId: e.data['userId'],
          advance: e.data['advance'],
          oStatus: e.data['oStatus'],
          dateFrom: e.data['dateFrom'],
          dateTo: e.data['dateTo'],
          selectedCar: e.data['selectedCar'],
          total: e.data['total']);
      ordersList.add(temp);
    }).toList();
    return ordersList;
  }

  // upload data to the firebase firestore

  Future<String> uploadOrderData(Order order) async {
    String result;
    try {
      await ordersCollection.document(order.oID).setData({
        'orderID': order.oID,
        'userId': order.userId,
        'orderStatus': order.oStatus,
        'dateFrom': order.dateFrom,
        'dateTo': order.dateTo,
        'selectedCar': order.selectedCar,
        'advance': order.advance,
        'total': order.total,
      });
      result = 'done';
      return result;
    } catch (e) {
      print('Error found');
      print(e);
      return null;
    }
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
