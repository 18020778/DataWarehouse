import 'dart:async';
import 'package:first_app/login_reg_pages/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage()));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(4281755726), Color(4284859275)],
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 150),
            Image.asset('assets/logo.png', width: 280, height: 280,),
            SizedBox(height: 10),

            Text('Little Garden',
            style: TextStyle(
              fontFamily: 'AkayaTelivigala',
              color: Colors.lime,
              fontSize: 34,
             ),
            ),
          ]
        )
        )
    );
  }
}
