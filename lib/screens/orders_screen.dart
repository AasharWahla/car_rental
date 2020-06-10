import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../models/Car.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrdersScreen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    List<Order> ordersList = [];
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
        body: ordersList.length == 0
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
                                i.car.carName,
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
                          i.car.carImage,
                          scale: 2,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList()));
  }
}
