import 'package:carrental/models/User.dart';
import 'package:carrental/providers/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/User.dart';
import './cars_list_screen.dart';

class AfterSignedIn extends StatefulWidget {
  final User user;
  AfterSignedIn(this.user);
  @override
  _AfterSignedInState createState() => _AfterSignedInState();
}

class _AfterSignedInState extends State<AfterSignedIn> {
  @override
  Widget build(BuildContext context) {
    print('user found');
    Navigator.pushReplacementNamed(context, CarsList.routeName);
    print('user found 2');
    return CarsList(
      activeUser: widget.user,
    );
//    return ChangeNotifierProvider(
//      create: (_) => CurrentUser(),
//      child: CarsList(
//        activeUser: widget.user,
//      ),
//    );
  }
}
