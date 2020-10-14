import 'package:flutter/material.dart';
import 'package:testapp/constants.dart';

class AlreadyHaveAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have account?" : "Already have an account",
          style: TextStyle(color: kprimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: TextStyle(color: kprimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
