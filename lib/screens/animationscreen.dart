import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p5/p5.dart';

class AnimationScreen extends StatefulWidget {
  AnimationScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'P5 Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: new AnimationScreen(title: 'P5 Demo Home Page'),
    );
  }
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  double _lowervalue = 50;
  bool callOnInit = true;
  MySketch sketch;
  PAnimator animator;
  @override
  void initState() {
    super.initState();
    makeSketch(_lowervalue);
    // sketch = new MySketch(0);
    // Need an animator to call the draw() method in the sketch continuously,
    // otherwise it will be called only when touch events are detected.
    // animator = new PAnimator(this);
    // animator.addListener(() {
    // setState(() {
    // sketch.redraw();
    // });
    // });
    // animator.run();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("P5 Draw!")),
      backgroundColor: const Color.fromRGBO(200, 200, 200, 1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PWidget(sketch),
            Container(
              child: FlutterSlider(
                values: [_lowervalue],
                min: 0,
                max: 180,
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  setState(() {
                    _lowervalue = lowerValue;
                    makeSketch(_lowervalue);
                  });
                },
                onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                  setState(() {
                    _lowervalue = lowerValue;
                    makeSketch(_lowervalue);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  makeSketch(_lowervalue) {
    sketch = new MySketch(_lowervalue);
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
}

class MySketch extends PPainter {
  double sliderVal;
  MySketch(double sliderVal) {
    this.sliderVal = sliderVal;
  }
  var n = 6;
  var d = 71;
  static const double pi = 3.141592653589;

  void setup() {
    size(400, 400);
  }

  void draw() {
    background(color(0, 0, 0));
    strokeWeight(1);
    translate(width / 2, height / 2);
    strokeWeight(2);
    var d = sliderVal;
    Fluttertoast.showToast(
        msg: d.toString(),
        textColor: Colors.black,
        backgroundColor: Colors.grey);
    stroke(Color(0xFF6F35A5));
    beginShape();
    for (var a = 0; a <= 360; a++) {
      var k = a * d;
      var r = 150 * sin(n * k * (pi / 180.0));
      var x = r * cos(k * (pi / 180.0));
      var y = r * sin(k * (pi / 180.0));
      vertex(x, y);
    }
    endShape();
    noFill();
    stroke(color(255, 0, 255, 255));
    strokeWeight(5);
    beginShape();
    for (var a = 0; a <= 360; a++) {
      var k = a;
      var r = 150 * sin(n * k * (pi / 180.0));
      var x = r * cos(k * (pi / 180.0));
      var y = r * sin(k * (pi / 180.0));
      vertex(x, y);
    }
    endShape();
  }
}
