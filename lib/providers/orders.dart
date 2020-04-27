import 'package:flutter/material.dart';

import '../models/Car.dart';

class Order {
  String carName;
  int duration;
  double total;
  double advance;
  String status = 'pending';
  Order({@required this.carName, @required this.duration, @required this.total, @required this.advance});
}

class Orders with ChangeNotifier{
  List<Order> orders = [];

  List<Order> get ordersList {
    if(orders.isEmpty){
      return null;
    } else {
      return [...orders];
    }
  }


  int ordersLength () {
    return orders.length;
  }

  void addOrder ({String carName, int carDuration, double carAmount, double carAdvance }) {
    orders.add(Order(carName: carName, duration: carDuration, total: carAmount, advance: carAdvance));
  }
}