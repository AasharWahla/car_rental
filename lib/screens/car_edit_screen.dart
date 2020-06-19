import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carrental/carData.dart';
import 'package:carrental/screens/addCar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:carrental/models/User.dart';
import 'package:provider/provider.dart';
import 'package:carrental/providers/currentUser.dart';
import 'package:carrental/models/Car.dart';
import 'package:carrental/services/database.dart';

class EditCar extends StatefulWidget {
  static const routeName = '/EditCar';
  @override
  _EditCarState createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  final _dbConnection = DatabaseService();
  List<Car> carsList;
  bool isLoading = true;

  @override
  void didChangeDependencies() async {
    carsList = await _dbConnection.getCarsData();
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  User test = User();
  @override
  Widget build(BuildContext context) {
    User activeUser = Provider.of<CurrentUser>(context).getActiveUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Select Car You want to Edit.'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 2,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (ctx) => AddCar(),
                      ),
                    );
                  },
                  child: Text('Add Car'),
                ),
              ),
            ],
          )
        ],
      ),
      body: isLoading
          ? Container(
              child: SpinKitFoldingCube(
              color: Colors.green,
              size: 40,
            ))
          : SingleChildScrollView(
              child: Column(
                children: carsList.map((car) {
                  return Stack(
                    children: <Widget>[
                      Positioned(
                        child: Container(
                          margin:
                              EdgeInsets.only(right: 15.0, top: 60.0, left: 15),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  car.carName,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HKGrotesk'),
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      car.carRate.toString(),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'HKGrotesk'),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        print('Car Engine : ${car.carEngine}');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (cx) => EditScreen(
                                              carToEdit: car,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.WARNING,
                                          headerAnimationLoop: true,
                                          animType: AnimType.BOTTOMSLIDE,
                                          title: 'WARNING',
                                          desc:
                                              'Are you sure you want to delete this car.',
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () {
                                            _dbConnection
                                                .deleteCar(car.carID)
                                                .then((value) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        EditCar()),
                                              );
                                            });
                                          },
                                        )..show();
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            elevation: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        height: 80,
                        right: 35,
                        bottom: 20,
                        child: Container(
                          child: Image.network(
                            car.carImage,
                            scale: 2,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }
}

class EditScreen extends StatefulWidget {
  final Car carToEdit;
  EditScreen({this.carToEdit});
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String name;
  String make;
  String rate;
  String image;
  String type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carToEdit.carName),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Name",
                style: TextStyle(fontSize: 26, color: Colors.blue),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: widget.carToEdit.carName),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'This field can not be empty';
                  } else {
                    return null;
                  }
                },
                onChanged: (val) {
                  name = val;
                },
              ),
              Text(
                "Make",
                style: TextStyle(fontSize: 26, color: Colors.blue),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: widget.carToEdit.carMake),
                onChanged: (val) {
                  make = val;
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'This field can not be empty';
                  } else {
                    return null;
                  }
                },
              ),
              Text(
                "Image Link",
                style: TextStyle(fontSize: 26, color: Colors.blue),
              ),
              TextFormField(
                decoration:
                    InputDecoration(hintText: widget.carToEdit.carImage),
                onChanged: (val) {
                  image = val;
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'This field can not be empty';
                  } else {
                    return null;
                  }
                },
              ),
              Text(
                "Rate",
                style: TextStyle(fontSize: 26, color: Colors.blue),
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: widget.carToEdit.carRate.toString()),
                onChanged: (val) {
                  rate = val;
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'This field can not be empty';
                  } else {
                    return null;
                  }
                },
              ),
              Text(
                "Type",
                style: TextStyle(fontSize: 26, color: Colors.blue),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: widget.carToEdit.carType),
                onChanged: (val) {
                  type = val;
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'This field can not be empty';
                  } else {
                    return null;
                  }
                },
              ),
              RaisedButton(
                child: Text(
                  "Save Changes",
                  style: TextStyle(fontSize: 26, color: Colors.blue),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    Car toEdit = Car(
                        carID: widget.carToEdit.carID,
                        carName: name,
                        carType: type,
                        carEngine: widget.carToEdit.carEngine,
                        carRate: int.parse(rate),
                        carImage: image,
                        carMake: make);

                    await _db.editCarInfo(toEdit).then((value) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (ctx) => EditCar()));
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmDelete extends StatelessWidget {
  final DatabaseService _db = DatabaseService();
  final String carID;
  ConfirmDelete(this.carID);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
