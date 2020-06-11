import 'dart:math';
import 'package:carrental/providers/currentUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Car.dart';
import '../widgets/booknow.dart';
import 'package:carrental/models/User.dart';

class CarDisplay extends StatefulWidget {
  static const routeName = '/routeCarDisplay';
  @override
  _CarDisplayState createState() => _CarDisplayState();
}

class _CarDisplayState extends State<CarDisplay> {
  User activeUser = User();
  void bookNow(BuildContext ctx, Car car, User activeUser) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return BookNow(
            currentCar: car,
            activeUser: Provider.of<CurrentUser>(context).getActiveUser(),
          );
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )));
  }

  Car car;

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> receivedArguments =
        ModalRoute.of(context).settings.arguments;
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    car = receivedArguments['car'];
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                left: mWidth * 0.02,
                child: GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 30,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                left: mWidth * .3,
                bottom: mHeight * .6,
                child: Container(
                  width: mHeight * .6,
                  height: mHeight * .6,
                  decoration: BoxDecoration(
                      color: Color(0xFFd0f1d7), shape: BoxShape.circle),
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: mHeight * .06,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: mWidth * .05,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  car.carName,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HKGrotesk'),
                                ),
                                Text(car.carMake,
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: 'HKGrotesk')),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: mWidth * .1,
                        ),
                        Hero(
                          tag: car.carID,
                          child: Image.network(
                            car.carImage,
                            scale: .9,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: min(mHeight * 0.05, 30),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: mWidth * .05, top: mWidth * .02),
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFd0f1d7),
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Specifications : ',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'HKGrotesk'),
                      ),
                    ),
                    SizedBox(
                      height: mHeight * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: mHeight * .15,
                          width: mHeight * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Color(0xFFd0f1d7),
                              width: 3,
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                child: Image.asset(
                                  'assets/images/car.png',
                                  scale: 1.3,
                                ),
                                right: mHeight * .01,
                              ),
                              Positioned(
                                bottom: 0,
                                right: mHeight * .03,
                                child: Text(
                                  car.carType,
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'HKGrotesk'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: mWidth * .2,
                        ),
                        Container(
                          height: mHeight * .15,
                          width: mHeight * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Color(0xFFd0f1d7),
                                width: 3,
                              )),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                child: Image.asset(
                                  'assets/images/engine.png',
                                  scale: 1.7,
                                ),
                                top: mHeight * .02,
                                right: mHeight * .03,
                              ),
                              Positioned(
                                bottom: 0,
                                right: mHeight * .01,
                                child: Text(
                                  car.carEngine,
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'HKGrotesk'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: mHeight * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: mHeight * .15,
                          width: mHeight * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Color(0xFFd0f1d7),
                              width: 3,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "PKR ${car.carRate}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'HKGrotesk'),
                              ),
                              Text(
                                'Price / Day',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: 'HKGrotesk'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: mWidth * .2,
                        ),
                        Container(
                          height: mHeight * .15,
                          width: mHeight * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Color(0xFFd0f1d7),
                              width: 3,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'N/A',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'HKGrotesk'),
                              ),
                              Text(
                                'Mileage',
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'HKGrotesk'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: mWidth,
                  height: mHeight * .12,
                  decoration: BoxDecoration(
                    color: Color(0XFF2D9067),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: GestureDetector(
                      child: Text(
                        'BOOK NOW',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'HKGrotesk'),
                      ),
                      onTap: () => bookNow(context, car, activeUser),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
