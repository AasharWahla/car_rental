import 'package:carrental/models/User.dart';
import 'package:carrental/screens/carDisplay_screen.dart';
import 'package:carrental/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return (user == null) ? HomeScreen() : CarDisplay();
  }
}
