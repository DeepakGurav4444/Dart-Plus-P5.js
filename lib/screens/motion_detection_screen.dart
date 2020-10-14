import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p5/p5.dart';
import 'package:sensors/sensors.dart';

class MotionDetectionScreen extends StatefulWidget {
  MotionDetectionScreen({Key key}) : super(key: key);

  @override
  _MotionDetectionScreenState createState() => _MotionDetectionScreenState();
}

class _MotionDetectionScreenState extends State<MotionDetectionScreen>
    with SingleTickerProviderStateMixin {
  List<double> _gyroscopeValues;
  Size size;
  int x = 50;
  MySketch sketch;
  PAnimator animator;
  bool turnedRight, turnedLeft = false;
  double gz = 0.0;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: PWidget(sketch),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  makeSketch(y) {
    sketch = new MySketch(y);
    // Need an animator to call the draw() method in the sketch continuously,
    // otherwise it will be called only when touch events are detected.
    animator = new PAnimator(this);
    animator.addListener(() {
      setState(() {
        sketch.redraw();
      });
    });
    animator.run();
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
        gz = event.z;
        if (gz > 1.0 && !turnedRight) {
          Fluttertoast.showToast(
              msg: "Turned Left",
              textColor: Colors.black,
              backgroundColor: Colors.grey,
              toastLength: Toast.LENGTH_SHORT);
          turnedLeft = true;
          x -= 50;
          // moveBall.leftMove();
        } else if (gz < -1.0 && !turnedLeft) {
          Fluttertoast.showToast(
              msg: "Turned Right",
              textColor: Colors.black,
              backgroundColor: Colors.grey,
              toastLength: Toast.LENGTH_SHORT);
          turnedRight = true;
          x += 50;
          // moveBall.rightMove();
        } else if (gz > 3.0 && turnedRight) {
          Fluttertoast.showToast(
              msg: "Turned Left",
              textColor: Colors.black,
              backgroundColor: Colors.grey,
              toastLength: Toast.LENGTH_SHORT);
          turnedLeft = true;
          // moveBall.leftMove();
          x -= 50;
        } else if (gz < -3.0 && turnedLeft) {
          Fluttertoast.showToast(
              msg: "Turned Right",
              textColor: Colors.black,
              backgroundColor: Colors.grey,
              toastLength: Toast.LENGTH_SHORT);
          turnedRight = true;
          // moveBall.rightMove();
          x += 50;
        }
      });
    }));
    makeSketch(x);
  }
}

class MySketch extends PPainter {
  int r = 100;
  int x;
  MySketch(int x) {
    this.x = x;
  }
  void setup() {
    fullScreen();
  }

  // void rightMove() {
  //   this.x += 15;
  // }

  // void leftMove() {
  //   this.x += 15;
  // }

  void draw() {
    background(color(255, 0, 0));
    rect(x, r, 50, 50);
    fill(Colors.green);
  }
}
