import 'package:carrental/screens/carDisplay_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../carData.dart';
import '../models/Car.dart';

class CarsList extends StatefulWidget {
  static const routeName = '/carslist';
  @override
  _CarsListState createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .05,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "Select the Car which suites you the best.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
              Column(
                children: carsList.map((car) {
                  return CarDisplayTile(car);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarDisplayTile extends StatelessWidget {
  final Car car;
  CarDisplayTile(this.car);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * .1,
              top: MediaQuery.of(context).size.height * .05,
              right: MediaQuery.of(context).size.width * .1),
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * .01),
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width * .7,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            car.carName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            car.carMake,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          car.carImage,
                          scale: 1.5,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                car.carRate,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(" /day"),
                            ],
                          ),
                          Container(),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * .3,
                  child: Center(
                    child: Text("Book Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF2D9067),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          elevation: 9,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onTap: () {
          Navigator.of(context)
              .pushNamed(CarDisplay.routeName, arguments: {'car': car});
        });
  }
}
