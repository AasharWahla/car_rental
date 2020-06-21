import 'package:carrental/providers/currentUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/Car.dart';
import 'package:carrental/services/database.dart';
import '../models/Order.dart';
import 'package:rich_alert/rich_alert.dart';
import 'package:carrental/models/User.dart';
import 'package:flutter/foundation.dart';

class BookNow extends StatefulWidget {
  final Car currentCar;
  final User activeUser;

  BookNow({this.currentCar, this.activeUser});
  @override
  _BookNowState createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  final _database = DatabaseService();
  void dateTimePicker(String check) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    ).then((selectedDate) {
      if (selectedDate == null) {
        return;
      } else {
        if (check == 'from') {
          setState(() {
            _fromSelectedDate = selectedDate;
          });
        } else {
          setState(() {
            _tillSelectedDate = selectedDate;
          });
        }
      }
    });
  }

  DateTime _fromSelectedDate;
  DateTime _tillSelectedDate;
  Order toUpload = Order();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).padding,
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'From : ',
                    style: TextStyle(fontFamily: 'HKGrotesk', fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _fromSelectedDate == null
                            ? 'No Date Chosen!'
                            : '${DateFormat('dd/MM/yyyy').format(_fromSelectedDate)}',
                        style: TextStyle(fontFamily: 'HKGrotesk', fontSize: 15),
                      ),
                      FlatButton(
                        onPressed: () {
                          dateTimePicker('from');
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side:
                                BorderSide(color: Color(0xFFd0f1d7), width: 5)),
                        child: Text('Select Date'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Text(
                    'Till : ',
                    style: TextStyle(fontFamily: 'HKGrotesk', fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _tillSelectedDate == null
                            ? "No Date Choosen!"
                            : "${DateFormat('dd/MM/yyyy').format(_tillSelectedDate)}",
                        style: TextStyle(fontFamily: 'HKGrotesk', fontSize: 15),
                      ),
                      FlatButton(
                        onPressed: () {
                          dateTimePicker("till");
                        },
                        child: Text('Select Date'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side:
                                BorderSide(color: Color(0xFFd0f1d7), width: 5)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(),
                  Text(
                    'Total Days : ',
                    style: TextStyle(fontFamily: 'HKGrotesk', fontSize: 20),
                  ),
                  Text(
                    _tillSelectedDate != null && _fromSelectedDate != null
                        ? _tillSelectedDate
                            .difference(_fromSelectedDate)
                            .inDays
                            .toString()
                        : '0',
                    style: TextStyle(fontFamily: 'HKGrotesk', fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(),
                  Text(
                    'Rate / Day : ',
                    style: TextStyle(fontFamily: 'HKGrotesk', fontSize: 20),
                  ),
                  Text(
                    widget.currentCar.carRate.toString(),
                    style: TextStyle(fontFamily: 'HKGrotesk', fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(),
                  Text(
                    'Total : ',
                    style: TextStyle(fontFamily: 'HKGrotesk', fontSize: 20),
                  ),
                  Text(
                    _tillSelectedDate != null && _fromSelectedDate != null
                        ? (_tillSelectedDate
                                    .difference(_fromSelectedDate)
                                    .inDays *
                                widget.currentCar.carRate)
                            .toString()
                        : '0',
                    style: TextStyle(fontFamily: 'HKGrotesk', fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(),
                  Text(
                    'Advance : ',
                    style: TextStyle(fontFamily: 'HKGrotesk', fontSize: 20),
                  ),
                  Text(
                    _tillSelectedDate != null && _fromSelectedDate != null
                        ? ((_tillSelectedDate
                                    .difference(_fromSelectedDate)
                                    .inDays *
                                widget.currentCar.carRate *
                                .5))
                            .toString()
                        : '0',
                    style: TextStyle(fontFamily: 'HKGrotesk', fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(color: Color(0xFFd0f1d7)),
                  child: Center(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'HKGrotesk',
                            fontSize: 30),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (_fromSelectedDate == null ||
                      _tillSelectedDate == null ||
                      _tillSelectedDate.difference(_fromSelectedDate).inDays <=
                          0) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return RichAlertDialog(
                            //uses the custom alert dialog
                            alertTitle: richTitle("Warning !"),
                            alertSubtitle:
                                richSubtitle("Kindly select the valid dates."),
                            alertType: RichAlertType.ERROR,
                          );
                        });
                  } else {
                    toUpload = Order(
                        userId: widget.activeUser.userID,
                        oID: DateTime.now().toIso8601String(),
                        advance: (_tillSelectedDate
                                    .difference(_fromSelectedDate)
                                    .inDays *
                                widget.currentCar.carRate *
                                .5)
                            .round(),
                        oStatus: 'Pending',
                        dateFrom: _fromSelectedDate.toString(),
                        dateTo: _tillSelectedDate.toString(),
                        total: (_tillSelectedDate
                                    .difference(_fromSelectedDate)
                                    .inDays *
                                widget.currentCar.carRate)
                            .round(),
                        selectedCar: widget.currentCar);
                    toUpload.oID = DateTime.now().toIso8601String();
                    toUpload.userId = widget.activeUser.userID;
                    toUpload.dateFrom = _fromSelectedDate.toString();
                    toUpload.dateTo = _tillSelectedDate.toString();
                    toUpload.selectedCar = widget.currentCar;
                    toUpload.oStatus = 'Pending';
                    toUpload.advance = (_tillSelectedDate
                                .difference(_fromSelectedDate)
                                .inDays *
                            widget.currentCar.carRate *
                            .5)
                        .round();
                    toUpload.total = (_tillSelectedDate
                                .difference(_fromSelectedDate)
                                .inDays *
                            widget.currentCar.carRate)
                        .round();
                    _database.uploadOrderData(toUpload).then((value) {
                      if (value == null) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return RichAlertDialog(
                                //uses the custom alert dialog
                                alertTitle: richTitle("Warning!"),
                                alertSubtitle: richSubtitle(
                                    "Due to some issue unable to place order."),
                                alertType: RichAlertType.ERROR,
                              );
                            });
                      } else {
                        print('Order uploaded');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RichAlertDialog(
                              //uses the custom alert dialog
                              alertTitle: richTitle("DONE!"),
                              alertSubtitle: richSubtitle(
                                  "The Booking is done successfully. \n You will shortly receive the confirmation message."),
                              alertType: RichAlertType.SUCCESS,
                            );
                          },
                        ).then((value) {
                          Navigator.pop(context);
                        });
                      }
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
