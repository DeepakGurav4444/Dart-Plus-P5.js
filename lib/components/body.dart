import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/components/rounded_button.dart';
import 'package:testapp/constants.dart';
import './background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome To Edu",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {},
            ),
            RoundedButton(
              text: "",
              color: kprimarylightColor,
              textColor: Colors.black,
              press: () {},
            )
          ],
        ),
      ),
    );
  }
}
