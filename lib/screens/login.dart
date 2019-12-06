import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacegate/screens/list_room.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _username = "";

  void _login() {
    if (_username != "") {
      Dio().post("https://rommyarb.dev/api/spacegate_users",
          data: {"username": _username}).then((r) async {
        // save to sharedpref
        var prefs = await SharedPreferences.getInstance();
        await prefs.setString("username", _username);
        await prefs.setBool("loggedIn", true);

        // navigate to ListRoom
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ListRoom()));
      }).catchError((err) {
        log(err.toString());
      });
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Hmm.."),
                content: Text("Mohon isi username."),
                actions: <Widget>[
                  FlatButton(
                    child: const Text('OK Sayang'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(25.0),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.blueGrey,
              child: Text("Logo"),
            ),
          ),
          TextField(
            decoration: InputDecoration(hintText: "Username"),
            onChanged: (value) {
              _username = value;
            },
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(hintText: "Password"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              child: Text("Login"),
              onPressed: _login,
            ),
          )
        ],
      ),
    ));
  }
}
