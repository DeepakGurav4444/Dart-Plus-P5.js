import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  double _lowervalue = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: FlutterSlider(
                values: [_lowervalue],
                min: 0,
                max: 180,
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  setState(() {
                    _lowervalue = lowerValue;
                    Fluttertoast.showToast(
                        msg: _lowervalue.toString(),
                        textColor: Colors.black,
                        backgroundColor: Colors.grey,
                        toastLength: Toast.LENGTH_SHORT);
                  });
                },
                onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                  setState(() {
                    _lowervalue = lowerValue;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
