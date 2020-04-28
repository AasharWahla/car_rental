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
    final orderData = Provider.of<Orders>(context);
    List<Order> ordersList = orderData.orders;
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
            ? Container(child: Text('No Orders Currently.'))
            : ListView.builder(
                itemCount: ordersList.length,
                itemBuilder: (_, i) {
                  Car x = ordersList[i].car;
                    return Container(
                      height: 200,
                      width: 100,
                      padding: EdgeInsets.all(20),
                      child: Stack(
                        children: <Widget>[

                          Positioned(
                            child: Container(
                              color: Colors.grey,
                              child: Padding(padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(x.carName),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("Total : ${ordersList[i].total}"),
                                      Spacer(),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ],
                                  )
                                ],
                              ),),
                            ),
                          ),
                          Positioned(
//                              height: 80,
                            right: 35,
                            bottom: 20,
                            child: Container(
                                child: Image.asset(x.carImage, scale: 2,)),
                          ),

                      ],
                      ),
                    );
//                  return Padding(
//                    padding: EdgeInsets.all(30),
//                    child: Card(
//                      child: Row(
//                        children: <Widget>[
//                          Column(
//                            children: <Widget>[
//                              Text(
//                                x.carName,
//                              ),
//                              Text("${ordersList[i].total}"),
//                            ],
//                          ),
//                          Image.asset(x.carImage)
//                        ],
//                      ),
//                      elevation: 20,
//                    ),
//                  );
                }));
  }
}
