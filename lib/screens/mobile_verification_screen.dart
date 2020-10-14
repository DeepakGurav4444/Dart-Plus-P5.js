import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/services/authservice.dart';
import './login_screen.dart';

class MobileVerificationScreen extends StatefulWidget {
  final String fullName, passWord;
  @override
  MobileVerificationScreen(this.fullName, this.passWord);
  _MobileVerificationScreenState createState() =>
      _MobileVerificationScreenState(fullName, passWord);
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> {
  String fullName, passWord;
  _MobileVerificationScreenState(String fullName, String passWord) {
    this.fullName = fullName;
    this.passWord = passWord;
  }
  AuthCredential phoneAuthCredential;
  final verifyKey = GlobalKey<FormState>();
  String mobileNo, oTP, verificationId, phoneNo;
  bool sentOTP = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Form(
          key: verifyKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Mobile Number Verification",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Image.asset(
                "assets/images/cell.png",
                height: size.width * 0.3,
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
                  validator: (String val) {
                    if (sentOTP) {
                      if (val.length > 10 || val.length < 10) {
                        return "Enter Valid Mobile Number";
                      }
                    } else {
                      if (val.length > 6 || val.length < 6) {
                        return "Enter Valid OTP";
                      }
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: sentOTP ? "Mobile:" : "Enter OTP:",
                    border: InputBorder.none,
                    icon: Icon(
                      sentOTP ? Icons.phone : Icons.lock,
                      color: kprimaryColor,
                    ),
                  ),
                  onChanged: (value) {
                    if (sentOTP) {
                      this.mobileNo = "+91" + value;
                      this.phoneNo = value;
                    } else {
                      this.oTP = value;
                    }
                  },
                ),
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
                        sentOTP ? "SEND OTP" : "VERIFY OTP",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (verifyKey.currentState.validate() && sentOTP) {
                          verifyPhone(mobileNo);
                        }
                        if (verifyKey.currentState.validate() && !sentOTP) {
                          AuthService().signInwithOtp(oTP, verificationId);
                          Future.delayed(const Duration(seconds: 3));
                          FirebaseAuth.instance.currentUser().then((user) {
                            if (user != null) {
                              saveUser();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return LoginScreen();
                                  },
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Wrong OTP",
                                  textColor: Colors.black,
                                  toastLength: Toast.LENGTH_LONG,
                                  backgroundColor: Colors.grey);
                            }
                          });
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  saveUser() {
    Map<String, dynamic> demoData = {
      "Name": fullName,
      "Password": passWord,
      "MobileNo": phoneNo
    };
    CollectionReference collectionReference =
        Firestore.instance.collection('Users');
    collectionReference.add(demoData);
  }

  Future<void> verifyPhone(mobileNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {};
    final PhoneVerificationFailed verificationFailed =
        (AuthException authResult) {
      Fluttertoast.showToast(
          msg: "Use Another Number",
          textColor: Colors.black,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.grey);
      print('${authResult.message}');
    };
    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        if (sentOTP) {
          sentOTP = !sentOTP;
        }
      });
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: mobileNo,
        timeout: const Duration(seconds: 20),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
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
              width: size.width * 0.3,
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
