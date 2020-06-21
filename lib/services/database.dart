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
  // upload data to the firebase firestore

  String carIdFromFutureCarObject;

  Future<String> uploadOrderData(Order order) async {
    String result;
    try {
      await ordersCollection.document(order.oID).setData({
        'orderID': order.oID,
        'userId': order.userId,
        'orderStatus': order.oStatus,
        'dateFrom': order.dateFrom,
        'dateTo': order.dateTo,
        'selectedCar': order.selectedCar.carID,
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

  Future<void> editCarInfo(Car toEdit) async {
    try {
      final result = await carsCollection.document(toEdit.carID).setData({
        'carName': toEdit.carName,
        'carImage': toEdit.carImage,
        'carRate': toEdit.carRate,
        'carMake': toEdit.carMake,
        'carType': toEdit.carType,
        'carEngine': toEdit.carEngine,
      });
    } catch (e) {
      print('Error editing car data on Firebase');
      print(e);
    }
  }

  Future<void> addNewCar(Car carToAdd) async {
    try {
      final result = await carsCollection.add({
        'carName': carToAdd.carName,
        'carImage': carToAdd.carImage,
        'carRate': carToAdd.carRate,
        'carMake': carToAdd.carMake,
        'carType': carToAdd.carType,
        'carEngine': carToAdd.carEngine,
      });
    } catch (e) {
      print('Error uploading the new car.');
      print(e);
    }
  }

  Future<void> deleteCar(String carToDeleteID) async {
    try {
      final result = carsCollection.document(carToDeleteID).delete();
    } catch (e) {
      print('Error uploading the new car.');
      print(e);
    }
  }

  Future<void> updateUserName(String userID, String updatedName) async {
    try {
      final result = usersCollection.document(userID).updateData({
        'userName': updatedName,
      });
    } catch (e) {
      print('Error updating user data.');
      print(e);
    }
  }

  Car selectedCarForOrder = Car();

  Future<void> orderSelectedCarByID(String carId) async {
    final result = await carsCollection.document(carId).get();
    Car toReturn = Car(
        carID: result.documentID,
        carName: result.data['carName'],
        carType: result.data['carType'],
        carEngine: result.data['carEngine'],
        carRate: result.data['carRate'],
        carImage: result.data['carImage'],
        carMake: result.data['carMake']);
    selectedCarForOrder = toReturn;
  }

  List<Order> ordersList = [];
  Future<List<Order>> getSpecificUserOrders(String userID) async {
    final result = await ordersCollection.getDocuments();
    result.documents.map((orders) {
      if (orders.data['userId'] == userID) {
        ordersList.add(
          Order(
            oID: orders.documentID,
            selectedCar: Car(carID: orders.data['selectedCar']),
            total: orders.data['total'],
            dateTo: orders.data['dateTo'],
            dateFrom: orders.data['dateFrom'],
            oStatus: orders.data['orderStatus'],
            advance: orders.data['advance'],
            userId: orders.data['userId'],
          ),
        );
      }
    }).toList();

    for (int i = 0; i < ordersList.length; i++) {
      await orderSelectedCarByID(ordersList[i].selectedCar.carID);
      ordersList[i].selectedCar = selectedCarForOrder;
    }
    return ordersList;
  }
}
