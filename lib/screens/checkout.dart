import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacegate/screens/done.dart';

class Checkout extends StatefulWidget {
  Checkout({Key key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Widget _kotak(
    String title,
    double w,
    double h,
    Color color,
  ) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      color: color,
      child: InkWell(
        child: SizedBox(
          height: h,
          width: w,
          child: Center(
              child: Text(
            title,
            style: TextStyle(fontSize: 15, color: Colors.white),
          )),
        ),
        onTap: () {},
      ),
    );
  }

  String _startTime = "00:00";
  String _endTime = "00:00";
  String _price = "";

  void _submit() async {
    var prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");

    Dio().post("https://rommyarb.dev/api/spacegate_bookings", data: {
      "username": username,
      "start_time": _startTime,
      "end_time": _endTime,
      "price": _price
    }).then((r) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Done(
                    endTime: _endTime,
                    startTime: _startTime,
                    price: _price,
                  )));
    }).catchError((err) {
      log(err.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          SizedBox(
            height: 24,
          ),
          Row(
            children: <Widget>[
              _kotak("Member", 100, 50, Colors.blueGrey),
              Expanded(
                child: SizedBox(),
              ),
              _kotak("Saldo", 100, 50, Colors.blueGrey)
            ],
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text("Start Time"),
              ),
              RaisedButton(
                child: Text(_startTime),
                onPressed: () async {
                  showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      }).then((time) {
                    String hour = time.hour.toString().length == 1
                        ? "0" + time.hour.toString()
                        : time.hour.toString();
                    String minute = time.minute.toString().length == 1
                        ? "0" + time.minute.toString()
                        : time.minute.toString();
                    log(hour + ":" + minute);
                    setState(() {
                      _startTime = hour + ":" + minute;
                    });
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text("End Time"),
              ),
              RaisedButton(
                child: Text(_endTime),
                onPressed: () async {
                  showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      }).then((time) {
                    String hour = time.hour.toString().length == 1
                        ? "0" + time.hour.toString()
                        : time.hour.toString();
                    String minute = time.minute.toString().length == 1
                        ? "0" + time.minute.toString()
                        : time.minute.toString();
                    log(hour + ":" + minute);
                    setState(() {
                      _endTime = hour + ":" + minute;
                    });
                  });
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text("Rp "),
              Expanded(
                child: TextField(
                  onChanged: (price) {
                    _price = price;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "..."),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: RaisedButton(
              child: Text("PAY"),
              onPressed: _submit,
            ),
          )
        ],
      ),
    );
  }
}
