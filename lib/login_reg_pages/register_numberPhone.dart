
import 'package:first_app/login_reg_pages/register_check_OTP.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:first_app/models/user.dart';
class regNumberPhone extends StatefulWidget {
  User user;
  @override
  _regNumberPhoneState createState() => _regNumberPhoneState();
  regNumberPhone({this.user});
}

class _regNumberPhoneState extends State<regNumberPhone> {
  String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text('Số điện thoại',
          style: TextStyle(fontSize: 22),),
        backgroundColor: Colors.green[900],
      ),
      body: Column(
        children: [
          SizedBox(height: 70,),
          Text('Nhập số điện thoại của bạn',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          textAlign: TextAlign.center,),
          SizedBox(height: 40,),
          Container(
            margin: EdgeInsets.fromLTRB(40, 0, 40, 40),
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.blue),
                )
            ),
            child: TextFormField(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                  hintText: ('Số điện thoại'),
                  hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              autofocus: true,
              onChanged: (value){
                if(value[0] == "0"){
                  this.phoneNumber = "+84" + value.substring(1, value.length);
                }else
                  this.phoneNumber = value;
              },
            ),
          ),
          Flexible(
              child: RaisedButton(
                color: Colors.green[800],
                padding: EdgeInsets.fromLTRB(140, 12, 140, 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                onPressed: () {
                  widget.user.setPhoneNumber(this.phoneNumber);
                  print(this.phoneNumber);
                 // _verifyPhone();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>regOTP(user: widget.user)));
                },
                child: Text("NEXT",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),),
              )
          ),
        ]
    )
    );
  }

}
