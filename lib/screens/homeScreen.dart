import 'cars_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFD0F1D7),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'assets/images/signin_one.png',
                    scale: 3,
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/signin_two.png',
                    scale: 3,
                  ),
                ),
              ],
            ),
              Positioned(
                top: mHeight*.3,
                left: mWidth*.15,
                child: Column(
                  children: <Widget>[

                    Text(
                      'Car Rental', style: TextStyle(
                      fontFamily: 'HKGrotesk',
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                    ),
                    Text(
                      'DB System - Project', style: TextStyle(
                      fontFamily: 'HKGrotesk',
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    SizedBox(
                      height: mHeight*.03,
                    ),
                    GestureDetector(
                      child: Container(
                        height: mHeight*.07,
                        width: mWidth*.7,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'SignIn with', style: TextStyle(
                                fontFamily: 'HKGrotesk',
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                            ),
                            CircleAvatar(
                              child: Image.asset('assets/images/google_avatar.png'),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.of(context).pushNamed(CarsList.routeName);
                      },
                    ),
                    SizedBox(
                      height: mHeight*.015,
                    ),
                    Text(
                      '- OR -', style: TextStyle(
                      fontFamily: 'HKGrotesk',
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    SizedBox(
                      height: mHeight*.015,
                    ),
                    GestureDetector(
                      child: Container(
                        height: mHeight*.07,
                        width: mWidth*.7,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'SignUp with', style: TextStyle(
                                fontFamily: 'HKGrotesk',
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                            ),
                            CircleAvatar(
                              child: Image.asset('assets/images/google_avatar.png'),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.of(context).pushNamed(CarsList.routeName);
                      },
                    ),
                  ],
                ),
              )
    ],
    ),
        ),
      ),
    );
  }
}
