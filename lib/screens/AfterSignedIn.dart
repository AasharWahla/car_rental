import 'package:carrental/models/User.dart';
import 'package:carrental/providers/currentUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  bool isLoading = true;
  @override
  void didChangeDependencies() async {
    await Provider.of<CurrentUser>(context)
        .setActiveUser(widget.user)
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    print('assigning the value');
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? IsLoading() : CarsList();
  }
}

class IsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD0F1D7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          SpinKitFoldingCube(
            color: Colors.green,
            size: 50,
          ),
        ],
      ),
    );
  }
}
