import 'package:flutter/material.dart';

import '../models/Car.dart';

class Order {
  Car car;
  int duration;
  double total;
  double advance;
  String status = 'pending';
  Order(
      {@required this.car,
      @required this.duration,
      @required this.total,
      @required this.advance});
}

class Orders with ChangeNotifier {
  List<Order> orders = [];

  List<Order> get ordersList {
    if (orders.isEmpty) {
      return null;
    } else {
      return [...orders];
    }
  }

  int ordersLength() {
    return orders.length;
  }

  void addOrder(
      {Car currentCar, int carDuration, double carAmount, double carAdvance}) {
    orders.add(Order(
        car: currentCar,
        duration: carDuration,
        total: carAmount,
        advance: carAdvance));
    notifyListeners();
  }
}
