import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network(
              "https://www.toyota-indus.com/wp-content/uploads/2018/01/camry-hybrid-discover-1.png"),
        ],
      ),
    );
  }
}
