import 'package:flutter/material.dart';
import 'package:spacegate/screens/checkout.dart';

class ListRoom extends StatefulWidget {
  ListRoom({Key key}) : super(key: key);

  @override
  _ListRoomState createState() => _ListRoomState();
}

class _ListRoomState extends State<ListRoom> {
  Widget _kotak(String title) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 2,
      color: Colors.blue,
      child: InkWell(
        child: SizedBox(
          height: 100,
          width: 100,
          child: Center(
              child: Text(
            title,
            style: TextStyle(fontSize: 30, color: Colors.white),
          )),
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Checkout()));
        },
      ),
    );
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
        Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              direction: Axis.horizontal,
              children: <Widget>[
                _kotak("A"),
                _kotak("B"),
                _kotak("C"),
                _kotak("D"),
                _kotak("E"),
                _kotak("F"),
                _kotak("G"),
                _kotak("H"),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
