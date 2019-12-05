import 'package:flutter/material.dart';
import 'package:spacegate/screens/list_room.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(hintText: "Password"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListRoom()));
              },
            ),
          )
        ],
      ),
    ));
  }
}
