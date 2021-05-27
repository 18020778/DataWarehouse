import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/login_reg_pages/register_name.dart';
import 'package:first_app/models/user.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class regWel extends StatefulWidget {
  @override
  _regWelState createState() => _regWelState();
}

class _regWelState extends State<regWel> {
  User user = new User();
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
                  SizedBox(height: 20,),
                  Image.asset('assets/logo.png', width: 180, height: 180,),
                  SizedBox(height: 50),
                  Text('Register for Little Garden!',
                    style: TextStyle(
                      fontFamily: 'AkayaTelivigala',
                      color: Colors.lime,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text('Chúng tôi sẽ giúp bạn tạo tài khoản mới \nsau vài bước dễ dàng',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.w400, fontSize: 20, height: 1.5),
                  ),
                  SizedBox(height: 120,),
                  Flexible(
                        child: RaisedButton(
                          color: Colors.white,
                          padding: EdgeInsets.fromLTRB(130, 12, 130, 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => regName(this.user)));
                            //(context);
                          },
                          child: Text("NEXT",
                            style: TextStyle(
                              fontSize: 20,
                            ),),

                        )
                    ),
                  SizedBox(height: 80,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already a member?  ",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => loginPage()));
                          },
                          child: Text("Login now",
                            style: TextStyle(color: Colors.lime, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
          ),
        )
    );
  }
}