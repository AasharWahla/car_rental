import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import '../models/Car.dart';

class BookNow extends StatefulWidget {
  final Car currentCar;
  BookNow({this.currentCar});
  @override
  _BookNowState createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
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
                          side: BorderSide(color: Color(0xFFd0f1d7), width: 5)),
                      child: Text('Select Date'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
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
                          side: BorderSide(color: Color(0xFFd0f1d7), width: 5)),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
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
            padding: const EdgeInsets.all(20.0),
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
            padding: const EdgeInsets.all(20.0),
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
                              double.parse(
                                  widget.currentCar.carRate.substring(3)))
                          .toString()
                      : '0',
                  style: TextStyle(fontFamily: 'HKGrotesk', fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
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
                                  double.parse(
                                      widget.currentCar.carRate.substring(3))) *
                              .09)
                          .toString()
                      : '0',
                  style: TextStyle(fontFamily: 'HKGrotesk', fontSize: 20),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(color: Colors.red),
            child: Center(
              child: Text(
                'Confirm',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
