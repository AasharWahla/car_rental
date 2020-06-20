import 'package:carrental/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carrental/models/Order.dart';
import '../models/Car.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrdersScreen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> ordersList = [];
  final _db = DatabaseService();
  bool isLoading = true;
  @override
  void initState() {
    _db.getOrdersData().then((value) {
      ordersList = value;
      print(ordersList.length);
      for (int i = 0; i < ordersList.length; i++) {
        print(ordersList[i].oID);
        print(ordersList[i].total);
        Car toReturn = carByFutureCar(ordersList[i].selectedCar);
        print(toReturn.carName);
      }
    });

    // TODO: implement initState
    super.initState();
  }

  Car toReturn = Car();
  Car carByFutureCar(Future<Car> futureCar) {
    futureCar.then((value) {
      toReturn = Car(
          carID: value.carID,
          carName: value.carName,
          carType: value.carType,
          carEngine: value.carEngine,
          carRate: value.carRate,
          carImage: value.carImage,
          carMake: value.carMake);
      setState(() {
        isLoading = false;
      });
    });
    return toReturn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Orders ',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xFFd0f1d7),
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ordersList.length == 0 && isLoading == true
            ? Container(
                child: Text(
                  'No Orders Currently.',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'HKGrotesk'),
                ),
              )
            : Column(
                children: ordersList.map((i) {
                Car userCar = carByFutureCar(i.selectedCar);
                return Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        margin:
                            EdgeInsets.only(right: 15.0, top: 60.0, left: 15),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                userCar.carName,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'HKGrotesk'),
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Total : ${i.total}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'HKGrotesk'),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              )
                            ],
                          ),
                          elevation: 20,
                        ),
                      ),
                    ),
                    Positioned(
                      height: 80,
                      right: 35,
                      bottom: 20,
                      child: Container(
                        child: Image.network(
                          userCar.carImage,
                          scale: 2,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList()));
  }
}
