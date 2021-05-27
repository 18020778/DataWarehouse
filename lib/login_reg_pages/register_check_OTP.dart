
import 'dart:io';

import 'package:first_app/login_reg_pages/login_page.dart';
import 'package:first_app/page_bottomNavBar/summary_page.dart';
import 'package:first_app/services/database.dart';
import 'package:first_app/services/uploadFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/models/user.dart';

class regOTP extends StatefulWidget {
  //String phoneNumber;
  User user;
  @override
  _regOTPState createState() => _regOTPState();
  regOTP({this.user});
}

class _regOTPState extends State<regOTP> {
  String verificationCode;
  String smsCode;
  bool _visible = false;
  bool _clearString = true;
  bool isExistedAccount = false;
  var _controler = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhone();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Text('Nhập mã xác minh',
            style: TextStyle(fontSize: 22),),
          backgroundColor: Colors.green[900],
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
              children: <Widget> [
                SizedBox(height: 70,),
                Text('Mã xác minh',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,),
                Text('Mã OTP được gửi về tin nhắn điện thoại của bạn',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,),
                SizedBox(height: 40,),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(40, 0, 40, 40),
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.blue),
                      )
                  ),
                  child: TextField(
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500, letterSpacing: 32),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                        border: InputBorder.none
                    ),
                    autofocus: true,
                    maxLength: 6,
                    controller: _controler,
                    onChanged: (val){
                      smsCode = val;
                      if(val.length == 6){
                        FirebaseAuth.instance.currentUser().then((user){
                          if(user!=null){
                            // User is signed in
                            FirebaseAuth.instance.signOut();
                          }else {
                            // No user is signed in11
                          }
                          _signIn();
                          print(user.uid);

                        });
                        if(_clearString)   _controler.clear();
                      }
                    },

                  ),

                ),
                  Visibility(
                    visible: _visible,
                    child:Text("Phone Number has been signed up.",
                      style: TextStyle(color: Colors.redAccent, fontSize: 18),
                    ),
                  ),
                SizedBox(height: 24,),
                Visibility(
                  visible: _visible,
                  child:Flexible(
                  child: SizedBox(
                      child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          color: Colors.green[700],
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=> loginPage())
                            );
                          },
                          child: Text("COME IN",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                            ),
                          )
                      )
                  ),
                ),
                )


                  ],
                ),
        ),


    );
  }
  // verify
  Future <void> verifyPhone() async {
    print("inside ");
    // Automatic handling of the SMS code on Android devices
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential credential) async{

    };


    // Handle failure events : invalid phoneNumber, ...
    final PhoneVerificationFailed phoneVerificationFailed = (AuthException exception){
      print("${exception.message}");

    };

    // Handle when a code has been sent to the sevice form Firebase
    final PhoneCodeSent phoneCodeSent = (String verId, [int forceCodeResend]){
      this.verificationCode = verId;
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId){
      this.verificationCode = verId;
    };


    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.user.getPhoneNumber(),
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }
  _signIn() async {
    AuthCredential phoneAuthCredential = PhoneAuthProvider.getCredential(verificationId: verificationCode, smsCode: smsCode);
    // Sign in to an existing phone number/ sign up with a new phonenumber
      FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then((user){
        //print("this is uid of user: " + user.user.uid);
        widget.user.setUid(user.user.uid);
      setState(() {
        _clearString = false;
      });
        Database().getUserInfo(user.user.uid.toString()).then((value){
          if(value == null) {
            _createAccount(widget.user);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>loginPage()),
            );
          }
          else {
            setState(() {
              this._visible = true;
          });}
        });
  }).catchError((e)=>print(e));
  }


  Future<String>  _createAccount(User user) async{

    String _resultSignUp = await Database().createUser(user);
  }
}
