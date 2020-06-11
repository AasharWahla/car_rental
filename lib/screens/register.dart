import 'package:carrental/models/User.dart';
import 'package:carrental/providers/currentUser.dart';
import 'package:carrental/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Register extends StatefulWidget {
  static const routeName = '/RegisterScreen';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isLoading = false;
  final _dbService = DatabaseService();
  final _auth = AuthService();
  String name;
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? IsLoading()
        : Scaffold(
            backgroundColor: Color(0xFFD0F1D7),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Center(
                child: Text(
                  'Register Screen',
                  style: TextStyle(
                    fontFamily: 'HKGrotesk',
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return "This Field can not be empty.";
                          } else if (val.length < 6) {
                            return "Minimum Length is six";
                          } else {
                            return null;
                          }
                        },
                        autocorrect: false,
                        onChanged: (val) {
                          name = val;
                        },
                        decoration: InputDecoration(
                          labelText: "Name",
                          icon: Icon(Icons.account_circle),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return "This Field can not be empty.";
                          } else if (!val.contains("@")) {
                            return "Invalid Email";
                          } else {
                            return null;
                          }
                        },
                        autocorrect: false,
                        onChanged: (val) {
                          email = val;
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          icon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return "This Field can not be empty.";
                          } else if (val.length < 6) {
                            return "Minimum Length is six";
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        autocorrect: false,
                        onChanged: (val) {
                          password = val;
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          icon: Icon(Icons.vpn_key),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RaisedButton(
//                  focusColor: Colors.blue,
                        splashColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 20,
                        color: Colors.white,
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          User toRegister = User(
                            userEmail: email,
                            userRole: 'C',
                            userName: name,
                            userID: null,
                          );
                          final result =
                              await _auth.registerUserWithEmailPassword(
                                  toRegister, password);
                          Navigator.pop(context);
                          if (result != null) {
                            final toUpload = User(
                              userID: result.userID,
                              userName: name,
                              userRole: 'C',
                              userEmail: email,
                            );
                            await _dbService.setUserData(toUpload);
                            Provider.of<CurrentUser>(context, listen: false)
                                .setActiveUser(result);
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontFamily: 'HKGrotesk',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
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
