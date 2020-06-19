import 'package:carrental/models/Car.dart';
import 'package:carrental/screens/car_edit_screen.dart';
import 'package:carrental/screens/cars_list_screen.dart';
import 'package:carrental/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCar extends StatefulWidget {
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    String name;
    String make;
    String type;
    String rate;
    String engine;
    String image;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a neww Car'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Car Name',
                ),
                onChanged: (val) {
                  name = val;
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'This field can not be empty';
                  } else if (val.length < 4) {
                    return 'This field minimum length is 4';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Car Make',
                ),
                onChanged: (val) {
                  make = val;
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'This field can not be empty';
                  } else if (val.length < 4) {
                    return 'This field minimum length is 4';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Car Type',
                ),
                onChanged: (val) {
                  type = val;
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'This field can not be empty';
                  } else if (val.length < 4) {
                    return 'This field minimum length is 4';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Car Rate',
                ),
                onChanged: (val) {
                  rate = val;
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'This field can not be empty';
                  } else if (val.length < 4) {
                    return 'This field minimum length is 4';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Car Engine',
                ),
                onChanged: (val) {
                  engine = val;
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'This field can not be empty';
                  } else if (val.length < 4) {
                    return 'This field minimum length is 4';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Car Image',
                ),
                onChanged: (val) {
                  image = val;
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'This field can not be empty';
                  } else if (val.length < 10) {
                    return 'This field minimum length is 4';
                  } else {
                    return null;
                  }
                },
              ),
              RaisedButton(
                child: Text('Add Car'),
                onPressed: () async {
                  final carToAdd = Car(
                      carID: null,
                      carName: name,
                      carType: type,
                      carEngine: engine,
                      carRate: int.parse(rate),
                      carImage: image,
                      carMake: make);
                  await _db.addNewCar(carToAdd).then((value) {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (ctx) => EditCar(),
                      ),
                    );
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
