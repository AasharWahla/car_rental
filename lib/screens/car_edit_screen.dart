import 'package:carrental/carData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:carrental/models/User.dart';
import 'package:provider/provider.dart';
import 'package:carrental/providers/currentUser.dart';
import 'package:carrental/models/Car.dart';
import 'package:carrental/services/database.dart';

class EditCar extends StatefulWidget {
  static const routeName = '/EditCar';
  @override
  _EditCarState createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  final _dbConnection = DatabaseService();
  List<Car> carsList;
  bool isLoading = true;

  @override
  void didChangeDependencies() async {
    carsList = await _dbConnection.getCarsData();
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  User test = User();
  @override
  Widget build(BuildContext context) {
    User activeUser = Provider.of<CurrentUser>(context).getActiveUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Select Car You want to Edit.'),
      ),
      body: null,
    );
  }
}
