import 'package:carrental/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carrental/models/Order.dart';
import '../models/Car.dart';
import 'package:carrental/providers/currentUser.dart';
import 'package:carrental/models/User.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrdersScreen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> ordersList = [];
  final _db = DatabaseService();
  bool isLoading = true;
  User activeUser = User();

  Future<void> updateOrdersData(String userId) async {
    print('Step 2');
    final result =
        await _db.getSpecificUserOrders(activeUser.userID).then((value) {
      ordersList = value;
      print('getting orders data from user');
    }).then((value) {
      setState(() {
        print('changing is loading to false 1');
        if (ordersList != null) {
          print('changing is loading to false 2');
          print('length : ' + ordersList.length.toString());
          isLoading = false;
          print('changing is loading to false');
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    print('Step 1');
    activeUser = Provider.of<CurrentUser>(context).activeUser;
    updateOrdersData(activeUser.userID).then((value) {
      print(ordersList[0].selectedCar.carID + '123123');
    });
    super.didChangeDependencies();
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
              children: ordersList.map(
                (i) {
                  return OrdersCard(
                    orderCar: i.selectedCar,
                    orderDetails: i,
                  );
                },
              ).toList(),
            ),
    );
  }
}

class OrdersCard extends StatefulWidget {
  final Car orderCar;
  final Order orderDetails;
  OrdersCard({this.orderCar, this.orderDetails});
  @override
  _OrdersCardState createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {
  bool showMore = false;
  @override
  Widget build(BuildContext context) {
    Car orderCar = widget.orderCar;
    Order orderDetails = widget.orderDetails;
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            margin: EdgeInsets.only(right: 15.0, top: 60.0, left: 15),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        orderCar.carName,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'HKGrotesk'),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Total : ${orderDetails.total}",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'HKGrotesk'),
                      ),
                      Spacer(),
                      GestureDetector(
                        child: Container(
                          height: 20,
                          width: 40,
                          child: Icon(
                            (!showMore)
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        onTap: () {
                          print(showMore.toString());
                          setState(() {
                            showMore = !showMore;
                            print('tapped');
                          });
                        },
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  (!showMore)
                      ? SizedBox(
                          width: 0.0,
                          height: 0.0,
                        )
                      : Container(
                          child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "From : ${DateFormat('dd/MM/yyyy').format(DateTime.parse(orderDetails.dateFrom))}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HKGrotesk'),
                                ),
                                Spacer(),
                                Text(
                                  "Till : ${DateFormat('dd/MM/yyyy').format(DateTime.parse(orderDetails.dateTo))}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HKGrotesk'),
                                ),
                                SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                            (orderDetails.oStatus == 'Pending')
                                ? Text(
                                    "Status : ${orderDetails.oStatus}",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'HKGrotesk'),
                                  )
                                : Text(
                                    "Status : ${orderDetails.oStatus}",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'HKGrotesk'),
                                  ),
                          ],
                        )),
                ],
              ),
              elevation: 20,
            ),
          ),
        ),
        Positioned(
          height: 80,
          right: 35,
          bottom: (showMore == true) ? 50 : 20,
          child: Container(
            child: Image.network(
              orderCar.carImage,
              scale: 2,
            ),
          ),
        ),
      ],
    );
  }
}
