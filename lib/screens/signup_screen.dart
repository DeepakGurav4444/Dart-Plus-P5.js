import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/screens/already_have_account_check.dart';
import 'package:testapp/screens/login_screen.dart';
import 'package:testapp/screens/mobile_verification_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();
  String fullName;
  String passWord;
  String confirmPassword;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Backgound(
          child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Text(
                  "SIGNUP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                  controller: fullnameController,
                  validator: (String val) {
                    if (val.isEmpty) {
                      return "Name can not be Empty";
                    } else if (val.length < 10) {
                      return ("Enter a Valid Name");
                    } else if (val.length > 30) {
                      return ("Should be less than 30 characters");
                    }
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: kprimaryColor,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      this.fullName = value;
                    });
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
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.email,
                      color: kprimaryColor,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: kprimaryColor,
                    ),
                  ),
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
                  decoration: InputDecoration(
                    hintText: "Adderess",
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.person_pin_circle,
                      color: kprimaryColor,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: kprimaryColor,
                    ),
                  ),
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
                  decoration: InputDecoration(
                    hintText: "Area Pincode",
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.pin_drop,
                      color: kprimaryColor,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: kprimaryColor,
                    ),
                  ),
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
                  controller: passwordController,
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
                    setState(() {
                      this.passWord = value;
                    });
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
                  controller: confirmpassController,
                  validator: (String val) {
                    if (val.isEmpty) {
                      return "can not be Empty";
                    } else if (val.length < 6) {
                      return "At least 6 characters required";
                    } else if (val.length > 16) {
                      return "Should be less than 16 characters";
                    }
                    if (val != passWord) {
                      return "Enter Same as Password";
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
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
                    setState(() {
                      this.confirmPassword = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    color: kprimaryColor,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        if (formKey.currentState.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MobileVerificationScreen(
                                    fullName, passWord);
                              },
                            ),
                          );
                        }
                      });
                    },
                  ),
                ),
              ),
              AlreadyHaveAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  }),
              Container(
                margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
                width: size.width * 0.8,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Color(0xFFD9D9d9),
                        height: 1.5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "OR",
                        style: TextStyle(
                            color: kprimaryColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFFD9D9D9),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: SvgPicture.asset(
                          "assets/icons/facebook.svg",
                          height: 20,
                          width: 20,
                        ),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: kprimaryColor),
                            shape: BoxShape.circle),
                      ),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: SvgPicture.asset(
                          "assets/icons/twitter.svg",
                          height: 20,
                          width: 20,
                        ),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: kprimaryColor),
                            shape: BoxShape.circle),
                      ),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: SvgPicture.asset(
                          "assets/icons/google-plus.svg",
                          height: 20,
                          width: 20,
                        ),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: kprimaryColor),
                            shape: BoxShape.circle),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class Backgound extends StatelessWidget {
  final Widget child;
  const Backgound({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              "assets/images/signup_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.25,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
