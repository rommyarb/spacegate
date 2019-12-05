import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Done extends StatefulWidget {
  final String endTime;
  final String startTime;
  final String price;
  Done({Key key, this.startTime, this.endTime, this.price}) : super(key: key);

  @override
  _DoneState createState() => _DoneState();
}

class _DoneState extends State<Done> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "QR Code",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: QrImage(
                data: widget.startTime + widget.endTime + widget.price,
                version: QrVersions.auto,
                size: 200,
              ),
            ),
            Text(
              "Time: " + widget.startTime + " - " + widget.endTime,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Rp " + widget.price,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
