import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/auth.dart';

class SingIn extends StatefulWidget {
  static const routeName = '/SignIn';
  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final _auth = AuthService();
  bool isLoading = false;
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? IsLoading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Center(
                child: Text(
                  'Login Screen',
                  style: TextStyle(
                    fontFamily: 'HKGrotesk',
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            backgroundColor: Color(0xFFD0F1D7),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .8,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              if (val.isEmpty) {
                                return "This Field Can not be empty!";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              email = val;
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              labelText: "Email",
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val.isEmpty) {
                                return "This Field can not be empty!";
                              } else if (val.length < 6) {
                                return "The length of the password can not be less than 6";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              password = val;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              icon: Icon(Icons.vpn_key),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              labelText: "Password",
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 20,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 30),
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  fontFamily: 'HKGrotesk',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              _formKey.currentState.validate();
                              setState(() {
                                isLoading = true;
                              });
                              final result =
                                  await _auth.signInUserWithEmailPassword(
                                      email: email, password: password);
                              if (result == null) {
                                setState(() {
                                  isLoading = false;
                                });
                              } else {
                                Navigator.pop(context);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
