import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';

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
        title: Text('Orders Screen.'),
      ),
      body: ordersList.length == 0 ?
      Container(child: Text('No Orders Currently.')) :
      Container(child: Text('Order Found')),
    );
  }
}
