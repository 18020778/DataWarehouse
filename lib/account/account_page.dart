import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/NewsFeed/create_blog.dart';
import 'package:first_app/NewsFeed/my_blog.dart';
import 'package:first_app/account/edit_info.dart';
import 'package:first_app/login_reg_pages/login_page.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/Sell/addProduct.dart';
import 'package:first_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountPage extends StatefulWidget {
  User user;
  @override
  _AccountPageState createState() => _AccountPageState();
  AccountPage({this.user});
}
class _AccountPageState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
        body: Column(
            children: [
              Container(
                height: 330,
                child: Stack(
                    children: [
                      Image.asset(
                        "assets/bg_account.jpg",
                        height: 310,
                        width: screenWidth,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 330,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Color(4291751385)
                                ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 5,
                                      spreadRadius: 2)
                                ]),
                                child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                    child: Image.network(
                                      widget.user.getUrlImage(),
                                      width: 130,
                                      height: 130,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                widget.user.getUserName(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 250,
                        left: (screenWidth - 350) / 2,
                        child: Container(
                          width: 350,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 5),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width:170 ,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "70",
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        "Bài đăng",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ]),
                              ),
                              VerticalDivider(
                                thickness: 1.5,
                              ),
                              Container(
                                width: 150,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "24",
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        "Bài viết",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(4291751385)
                    ),
                    child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Container(
                            height: 2,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                          FlatButton(onPressed: () async {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    EditInfo(user: widget.user))).then((value) {
                              if(value!=null){
                                setState(() {
                                  widget.user = value;
                                });
                              }
                            });
                          },
                              child: Row(
                                children: [
                                  Icon(Icons.account_circle_rounded),
                                  Text(" Thông tin cá nhân", style: TextStyle(
                                      fontSize: 20),),
                                  new Spacer(),
                                  Text("Chỉnh sửa", style: TextStyle(
                                      color: Colors.black54, fontSize: 15),),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              )
                          ),
                          Container(
                            height: 2,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                          FlatButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => AddProduct(user: widget.user)));
                          },
                              child: Row(
                                children: [
                                  Image.asset("assets/sell_icon.png", width: 20,
                                      fit: BoxFit.cover),
                                  Text(" Đăng bài bán hàng", style: TextStyle(
                                      fontSize: 20),),
                                  new Spacer(),
                                  Text("Thêm", style: TextStyle(
                                      color: Colors.black54, fontSize: 15),),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              )
                          ),
                          Container(
                            height: 2,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                          FlatButton(onPressed: () {
                            // Navigator.push(context,  MaterialPageRoute(builder: (context) => DetailBlog()));
                          },
                              child: Row(
                                children: [
                                  Icon(Icons.assignment),
                                  Text(" Bài đã đăng", style: TextStyle(
                                      fontSize: 20),),
                                  new Spacer(),
                                  Text("Chỉnh sửa", style: TextStyle(
                                      color: Colors.black54, fontSize: 15),),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              )
                          ),
                          Container(
                            height: 2,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                          FlatButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => CreateBlog(user: widget.user,)));
                          },
                              child: Row(
                                children: [
                                  // Image.asset("assets/sell_icon.png", width: 20,
                                  //     fit: BoxFit.cover),
                                  Icon(Icons.wb_incandescent_rounded),
                                  Text("Chia sẻ cẩm nang", style: TextStyle(
                                      fontSize: 20),),
                                  new Spacer(),
                                  Text("Thêm", style: TextStyle(
                                      color: Colors.black54, fontSize: 15),),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              )
                          ),
                          Container(
                            height: 2,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                          FlatButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) =>
                                MyBlog(user: widget.user,)));
                          },
                              child: Row(
                                children: [
                                  // Image.asset("assets/sell_icon.png", width: 20,
                                  //     fit: BoxFit.cover),
                                  Icon(Icons.web_sharp),
                                  Text("Các bài viết", style: TextStyle(
                                      fontSize: 20),),
                                  new Spacer(),
                                  Text("Thêm", style: TextStyle(
                                      color: Colors.black54, fontSize: 15),),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              )
                          ),
                          Container(
                            height: 2,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                          Container(
                            height: 2,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                          FlatButton(onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.history, size: 19),
                                  Text(" Lịch sử mua hàng", style: TextStyle(
                                      fontSize: 20),),
                                  new Spacer(),
                                  Text("Xem", style: TextStyle(
                                      color: Colors.black54, fontSize: 15),),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              )
                          ),
                          Container(
                            height: 2,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                          FlatButton(onPressed: () {},
                              child: Row(
                                children: [
                                  Image.asset("assets/star.png", width: 25,
                                    height: 25,
                                    fit: BoxFit.cover,),
                                  Text(" Đánh giá cửa hàng", style: TextStyle(
                                      fontSize: 20),),
                                  new Spacer(),
                                  Text("Chỉnh sửa", style: TextStyle(
                                      color: Colors.black54, fontSize: 15),),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              )
                          ),
                          Container(
                            height: 7,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                          SizedBox(height: 15,),
                          FlatButton(onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => loginPage()));
                          },
                            padding: EdgeInsets.zero,
                            child:
                            Text("Đăng xuất", style: TextStyle(fontSize: 24),),
                          ),
                          // Positioned(
                          //   child: FlatButton(onPressed: (){
                          //     Database().deleteUser(widget.user.getUid());
                          //     FirebaseAuth.instance.currentUser().then((value){
                          //       value.delete();
                          //     });
                          //     Navigator.pop(context);
                          //   },
                          //     padding: EdgeInsets.zero,
                          //     child:
                          //     Text("Yêu cầu hủy tài khoản", style: TextStyle(
                          //         fontSize: 17, color: Colors.black54),),
                          //   ),)
                        ]),
                  ),
                ),
              ),
            ])
    );
  }

}