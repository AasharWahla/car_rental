import 'package:carrental/models/Car.dart';
import 'package:flutter/material.dart';
import './services/database.dart';

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  final _dbConnection = DatabaseService();
  List<Car> carsList;
  void gettingData() {}
  bool isLoading = true;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    carsList = await _dbConnection.getCarsData();
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  color: Colors.blue,
                  child: Text("Loading"),
                ),
              )
            : Column(
                children: carsList.map((e) {
                  return Container(
                    child: Text("done"),
                  );
                }).toList(),
              ));
  }
}
