import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/screens/animationscreen.dart';
// import 'package:testapp/screens/animationscreen.dart';
import 'package:testapp/screens/signup_screen.dart';
import 'package:testapp/screens/testscreen.dart';
import './already_have_account_check.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginformKey = GlobalKey<FormState>();
  RegExp numeric = RegExp(r'^-?[0-9]+$');
  RegExp emailReg =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z]+");
  TextEditingController emailORphoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String emailORphone;
  String passWord;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
            child: Form(
          key: loginformKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN PAGE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Image.asset(
                "assets/images/recycle.png",
                width: size.width * 0.35,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: size.width * 0.8,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: kprimarylightColor,
                    borderRadius: BorderRadius.circular(29)),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: emailORphoneController,
                  validator: (String val) {
                    if (numeric.hasMatch(val)) {
                      if (val.length > 10 || val.length < 10) {
                        return "Enter Valid Mobile Number";
                      }
                    } else {
                      if (!emailReg.hasMatch(val)) {
                        return "Enter Valid Email Adderess";
                      }
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Mobile No.",
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: kprimaryColor,
                    ),
                  ),
                  onChanged: (value) {
                    this.emailORphone = value;
                  },
                ),
              ),
              Container(
                width: size.width * 0.8,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                    color: kprimarylightColor,
                    borderRadius: BorderRadius.circular(29)),
                child: TextFormField(
                  controller: passController,
                  validator: (String val) {
                    if (val.isEmpty) {
                      return "can not be Empty";
                    } else if (val.length < 6) {
                      return "At least 6 characters required";
                    } else if (val.length > 16) {
                      return "Should be less than 16 characters";
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      color: kprimaryColor,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: kprimaryColor,
                    ),
                  ),
                  onChanged: (value) {
                    this.passWord = value;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Forgot Password?",
                    style: TextStyle(color: kprimaryColor),
                  ),
                  GestureDetector(
                    child: Text(
                      "Click Here",
                      style: TextStyle(
                          color: kprimaryColor, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                      color: kprimaryColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() async {
                          if (loginformKey.currentState.validate()) {
                            await Firestore.instance
                                .collection("Users")
                                .where("MobileNo", isEqualTo: emailORphone)
                                .where("Password", isEqualTo: passWord)
                                .getDocuments()
                                .then((event) {
                              if (event.documents.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return AnimationScreen();
                                    },
                                  ),
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "Login failed! Wrong Email or Password!",
                                    textColor: Colors.black,
                                    backgroundColor: Colors.grey);
                              }
                            });
                          }
                        });
                      }),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              AlreadyHaveAccountCheck(
                login: true,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignUpScreen();
                  }));
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
