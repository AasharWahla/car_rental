import 'package:carrental/main.dart';
import 'package:carrental/screens/Wrapper.dart';
import 'package:carrental/screens/cars_list_screen.dart';
import 'package:carrental/services/database.dart';
import 'package:flutter/material.dart';
import '../models/User.dart';

class UserProfile extends StatefulWidget {
  final User activeUser;
  UserProfile({this.activeUser});
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Name'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: (val) {
                  name = val;
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'This field can not be empty';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Edit User Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),
              RaisedButton(
                splashColor: Colors.green,
                child: Text('Submit'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await _db.updateUserName(widget.activeUser.userID, name);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (xt) => MyApp(),
                      ),
                    );
                  } else {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
