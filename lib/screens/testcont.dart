import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import "package:flutter/material.dart";

class constscreen extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Deeapk",
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Deepak Gurav"),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Deeapk",
                    textDirection: TextDirection.ltr,
                  ),
                  Text("Gurav",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 40.0, color: Colors.red[200])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('images/school.png'),
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                            image: AssetImage('images/school.png'),
                            fit: BoxFit.fill,
                          )),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: "Clicked",
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white);
                    },
                  ),
                  RaisedButton(
                    color: Colors.red,
                    child: Text(
                      "Click Me",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      final context = navigatorKey.currentState.overlay.context;
                      final popUp = AlertDialog(
                        title: Text("Clicked Successfully!"),
                        content: Text(
                          "Enjoy The App!",
                        ),
                        backgroundColor: Colors.yellow,
                      );
                      showDialog(
                          context: context, builder: (BuildContext) => popUp);
                    },
                  )
                ],
              )
            ],
          ))),
    );
  }
}
