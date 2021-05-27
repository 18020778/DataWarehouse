
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/login_reg_pages/register_welcome.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/page_bottomNavBar/summary_page.dart';
import 'package:first_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String phoneNumber;
  String userName;
  String email;
  String password;
  String confirmPass;
  String verificationCode;
  String smsCode;
  bool _visible = false;
  final txt = TextEditingController();

  clearTextInput() {
    txt.clear();
  }

  @override
  Widget build(BuildContext context) {
    PageController controller =
    PageController(viewportFraction: 0.4, initialPage: 1);

    return Scaffold(
      body: SingleChildScrollView(
       child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.green[900],
            ),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: <Widget>[
                    SizedBox(height: 20),
                    Image.asset('assets/logo.png', width: 180, height: 170,),
                    SizedBox(height: 20),
                    Text('Welcome to Little Garden!',
                      style: TextStyle(
                        fontFamily: 'AkayaTelivigala',
                        color: Colors.lime,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(height: 40,),
                    _textInput(hint: "Number Phone", icon: Icons.phone),
                    Visibility(visible: !_visible, child: SizedBox(height: 80,)),
                    Visibility(
                        visible: _visible,
                        child: Container(
                            margin: EdgeInsets.only(
                                top: 20, bottom: 40, right: 30),
                            alignment: Alignment.centerRight,
                            child: Text("Account is not registered",
                              style: TextStyle(
                                  color: Colors.red
                              ),)
                        )),

                    Flexible(
                      child: SizedBox(
                          child: RaisedButton(
                            padding: EdgeInsets.fromLTRB(150, 12, 150, 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),

                            onPressed: () async {
                              FirebaseAuth.instance.signOut();
                              _verifyPhone();
                            },
                            child: Text("LOGIN",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                      ),
                    ),
                    SizedBox(height: 140,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?  ",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => regWel()));
                              },
                              child: Text("Registor",
                                style: TextStyle(color: Colors.lime, fontSize: 20),
                              ),
                            )
                          ]
                      ),
                    )
                  ]
              ),
            )
      )
      );
  }

  Widget _textInput({controller, hint, icon}) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.white),
            left: BorderSide(width: 1.0, color: Colors.white),
          )
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 20, color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white,),
        ),
        onChanged: (value) {
          if (value[0] == "0") {
            this.phoneNumber = "+84" + value.substring(1, value.length);
          } else
            this.phoneNumber = value;
        },

      ),
    );
  }

  Future <void> _verifyPhone() async {
    print("inside verifyPhone");
    // Automatic handling of the SMS code on Android devices
        final PhoneVerificationCompleted verificationCompleted = (
            AuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        };


        // Handle failure events : invalid phoneNumber, ...
        final PhoneVerificationFailed phoneVerificationFailed = (
            AuthException exception) {
          print("${exception.message}");
        };

        // Handle when a code has been sent to the sevice form Firebase
        final PhoneCodeSent phoneCodeSent = (String verId, [int forceCodeResend]) {
          this.verificationCode = verId;
          smsCodeDialog(context).then((value) =>
          {
            print("Signed In")
          }
          );
        };

        final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
          this.verificationCode = verId;
        };


        await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: this.phoneNumber,
            timeout: const Duration(seconds: 5),
            verificationCompleted: verificationCompleted,
            verificationFailed: phoneVerificationFailed,
            codeSent: phoneCodeSent,
            codeAutoRetrievalTimeout: autoRetrievalTimeout);


  }

  Future<bool> smsCodeDialog(BuildContext context) async {
    return showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Enter Code",
                  style: TextStyle(
                      color: Colors.green[900],
                      fontSize: 20
                  ),),
                content: TextField(
                  controller: txt,
                  onChanged: (val) {
                    smsCode = val;
                    if (val.length == 6) {
                      FirebaseAuth.instance.currentUser().then((user) {
                        if (user != null) {
                          clearTextInput();
                          FirebaseAuth.instance.signOut();
                        } else {
                          clearTextInput();
                          signIn();
                        }
                      });
                    }
                  },
                  autofocus: true,
                  maxLength: 6,
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 30,
                    letterSpacing: 23,

                  ),
                ),
              );
            }
        );

  }

  signIn() {
    AuthCredential phoneAuthCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationCode, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then((
        user) {
      Database().getUserInfo(user.user.uid.toString()).then((value) {
        //print("This is userUid : "+user.user.uid.toString());
        if (value == null) {
          Navigator.of(context).pop();
          setState(() {
            this._visible = true;
          });
        }
        else{
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SummaryPage(user: value)));
        }

      });
    });
  }
}
