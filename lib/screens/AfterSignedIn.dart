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
    Future.delayed(Duration(seconds: 5));
    return isLoading
        ? IsLoading()
        : CarsList(
            activeUser: widget.user,
          );
  }
}

class IsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loading"),
      ),
    );
  }
}
