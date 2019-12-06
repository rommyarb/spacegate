import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacegate/screens/list_room.dart';
import 'package:spacegate/screens/login.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

void main() => runApp(Main());

class Main extends StatefulWidget {
  const Main({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();

    // PUSHY
    Pushy.listen();
    Pushy.requestStoragePermission();
    pushyRegister();
  }

  Future pushyRegister() async {
    try {
      String deviceToken = await Pushy.register();

      print('Device token: $deviceToken');
    } on PlatformException catch (error) {
      // Display an alert with the error message
      log(error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> checkAuth() async {
      var prefs = await SharedPreferences.getInstance();
      var loggedIn = prefs.getBool("loggedIn") ?? false;
      log("loggedIn: " + loggedIn.toString());
      return loggedIn;
    }

    return MaterialApp(
        title: 'Spacegate',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: checkAuth(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data) {
                  return ListRoom();
                } else {
                  return Login();
                }
              } else {
                return Center(
                  child: Text("Loading..."),
                );
              }
              ;
            }));
  }
}
