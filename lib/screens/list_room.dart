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
  List<Widget> _rooms = [];

  @override
  void initState() {
    super.initState();

    Dio()
        .get("https://rommyarb.dev/api/spacegate_rooms",
            options: Options(responseType: ResponseType.json))
        .then((r) {
      var data = r.data['data'];
      List<Widget> rooms = [];
      data.forEach((room) {
        rooms.add(ListTile(
          leading: Icon(Icons.home),
          title: Text(room['title']),
          onTap: () {
            log("clicked!");
          },
        ));
      });
      setState(() {
        _rooms = rooms;
      });
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
        backgroundColor: Colors.amberAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 44, left: 20, right: 20, bottom: 20),
              child: Text(
                "List of coworking space",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              child: ListView(
                children: _rooms,
              ),
            )
          ],
        ));
  }
}
