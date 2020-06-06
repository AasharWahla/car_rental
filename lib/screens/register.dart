import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  static const routeName = '/RegisterScreen';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name;
  String email;
  String phoneNumber;
  String password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    } else if (val.length < 6) {
                      return "Minimum Length is six";
                    } else {
                      return null;
                    }
                  },
                  autocorrect: false,
                  onChanged: (val) {
                    phoneNumber = val;
                  },
                  decoration: InputDecoration(
                    labelText: "Mobile # ",
                    icon: Icon(Icons.phone),
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
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
