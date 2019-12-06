import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import 'package:spacegate/screens/checkout.dart';

class ListRoom extends StatefulWidget {
  ListRoom({Key key}) : super(key: key);

  @override
  _ListRoomState createState() => _ListRoomState();
}

class _ListRoomState extends State<ListRoom> {
  List<Map<String, dynamic>> _rooms = [];

  Widget _roomWidgets() {
    var widgets = [];
    _rooms.forEach((room) {
      widgets.add(ListTile(
        leading: Icon(Icons.home),
        title: Text(room['title']),
      ));
    });
    return Expanded(
      child: ListView(
        children: widgets,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Dio().get("https://rommyarb.dev/api/spacegate_rooms").then((r) {
      log(r.data.toString());
      var rooms = jsonDecode(r.data);
      log(rooms.toString());
    }).catchError((err) {
      log(err.toString());
    });

    // Listen for push notifications
    Pushy.setNotificationListener((Map<String, dynamic> data) {
      // Print notification payload data
      print('Received notification: $data');

      // Extract notification messsage
      String message = data['message'] ?? 'Notifikasi masuk!';

      // Display an alert with the "message" payload value
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text('Pushy'),
                content: Text(message),
                actions: [
                  FlatButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      })
                ]);
          });

      // Clear iOS app badge number
      // Pushy.clearBadge();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "List of coworking space",
            style: TextStyle(fontSize: 16),
          ),
        ),
        _roomWidgets()
      ],
    ));
  }
}
