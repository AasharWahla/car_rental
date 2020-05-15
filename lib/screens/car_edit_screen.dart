import 'package:carrental/carData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditCar extends StatefulWidget {
  static const routeName = '/EditCar';
  @override
  _EditCarState createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Edit Cars'),
      ),
      body: Text(
        'Edit the Car.'
      ),
    );
  }
}
