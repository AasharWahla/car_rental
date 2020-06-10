import 'package:flutter/foundation.dart';

enum carTypes { sedan, crossover, suv, hatchback, truck, convertible }

class Car {
  final String carID;
  final String carName;
  final String carType;
  final String carEngine;
  final int carRate;
  final String carImage;
  final String carMake;
  Car({
    @required this.carID,
    @required this.carName,
    @required this.carType,
    @required this.carEngine,
    @required this.carRate,
    @required this.carImage,
    @required this.carMake,
  });
}
