import './screens/carDisplay_screen.dart';

import './screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/cars_list_screen.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Rental',
      routes: {
        '/' :(ctx) => HomeScreen(),
        CarsList.routeName : (ctx) => CarsList(),
        CarDisplay.routeName : (ctx)=>CarDisplay(),
      },
    );
  }
}
