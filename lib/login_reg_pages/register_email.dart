import 'package:first_app/login_reg_pages/register_numberPhone.dart';
import 'package:first_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/user.dart';
class regEmail extends StatefulWidget {
  User user;
  @override
  _regEmailState createState() => _regEmailState();
  regEmail(this.user);
}

class _regEmailState extends State<regEmail> {
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Text('Email',
            style: TextStyle(fontSize: 22),),
          backgroundColor: Colors.green[900],
        ),
        body: Column(
            children: [
              SizedBox(height: 70,),
              Text('Nhập Email',
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
                    hintText: ('Email'),
                    hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  autofocus: true,
                  onChanged: (val){
                    this.email = val;
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
                      widget.user.setEmail(this.email);
                      // _signUp(widget.user);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => regNumberPhone(user: widget.user)));
                    },
                    child: Text("Next",
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
