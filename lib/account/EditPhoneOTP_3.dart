import 'package:first_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/models/user.dart';

import 'edit_info.dart';

class phoneOTP extends StatefulWidget {
  @override
  phoneOTPState createState() => phoneOTPState();
}

class phoneOTPState extends State<phoneOTP> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: Text('Nhập mã xác minh',
          style: TextStyle(fontSize: 22),),
        backgroundColor: Color(0xFF407C5A),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(height: 70,),
            Text('Mã xác minh',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
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
                  style: TextStyle(fontSize: 35,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 32),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                      border: InputBorder.none
                  ),
                )
            ),
            SizedBox(height: 24,),
            Visibility(
              child: Flexible(
                child: SizedBox(
                    child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        color: Color(0xFF407C5A),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  EditInfo())
                          );
                        },
                        child: Text("Hoàn thành",
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
}
  // verify
/*  Future <void> verifyPhone() async {
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
      widget.user.setUid(user.user.uid);
      setState(() {
        _clearString = false;
      });
      Database().getUserInfo(user.user.uid.toString()).then((value){
        if(value == null) {
          _createAccount(widget.user);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>MenuPage()),
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
    print(_resultSignUp);
  }
}
*/