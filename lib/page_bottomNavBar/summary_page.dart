
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/NewsFeed/summary_news.dart';
import 'package:first_app/account/account_page.dart';
import 'package:first_app/login_reg_pages/loading.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/database.dart';
import 'package:first_app/services/uploadFile.dart';
import 'package:first_app/show_products_page/body_home_0.dart';
import 'package:first_app/show_products_page/type_of_trees_1.dart';
import 'package:first_app/wallet/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'liked_page.dart';
import 'package:first_app/models/shippingInfor.dart';
class SummaryPage extends StatefulWidget {
  User user;
  SummaryPage({this.user});
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  var _currentIndex = 0;
  bool viewResult = false;
  List<shippingInfor> listAddress = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Database().getAllAddress(widget.user.getUid()).then((QuerySnapshot docs){
      var count = docs.documents.length;
      if(docs.documents.isNotEmpty){
        docs.documents.forEach((element) {
          listAddress.add(shippingInfor.fromJson(element.data));
        });
      }
      if(listAddress.length == count){
        widget.user.listShippingInfor = listAddress;
        setState(() {
          this.viewResult = true;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    // User.

    // getCurrentUid().then((value) => getUid(value.toString()));
    // Database().getUserInfo(this.uid).then((value) => getUser(value));
    //print("uid hahaha : " +  this.uid);

    List<Widget> _bodyTabs() => [
      bodyHome(user: widget.user),
      SummaryNews(user: widget.user,),
      LikedPage(user: widget.user,),
      AccountPage(user: widget.user)
    ];

    final List<Widget> bodyTabs = _bodyTabs();
    var height = (_currentIndex == 0 ? 117.0 : 100.0);


    return this.viewResult ? Scaffold(

      body: bodyTabs[_currentIndex],
      bottomNavigationBar: BottomNavBar(),

    ): Loading();
  }

  BottomNavBar() {
    return BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.home,
              color: Color(4281755726),
              size: 27.0,
            ),
            activeIcon: Icon(
            FontAwesomeIcons.home,
            color: Color(0xFF488B66),
            size: 27.0,
            ),
            title: Text(
              'Trang chủ',
              style: TextStyle(
                  color: Color(0xFF488B66)
              ),
            ),
          ),
         /* BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.wallet,
              color: Color(4281755726),
              size: 27.0,
            ),
            activeIcon: Icon(
              FontAwesomeIcons.wallet,
              color: Color(0xFF488B66),
              size: 27.0,
            ),
            title: Text(
              'Ví điện tử',
              style: TextStyle(
                  color: Color(0xFF488B66)
              ),
            ),
          ),*/
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.solidNewspaper,
              color: Color(4281755726),
              size: 27.0,
            ),
            activeIcon: Icon(
              FontAwesomeIcons.solidNewspaper,
              color: Color(0xFF488B66),
              size: 27.0,
            ),
            title: Text(
              'Cẩm nang',
              style: TextStyle(
                  color: Color(0xFF488B66)
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.solidHeart,
              color: Color(4281755726),
              size: 27.0,
            ),
            activeIcon: Icon(
              FontAwesomeIcons.solidHeart,
              color: Color(0xFF488B66),
              size: 27.0,
            ),
            title: Text(
              'Đã thích',
              style: TextStyle(
                  color: Color(0xFF488B66)
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.solidUser,
              color: Color(4281755726),
              size: 27.0,
            ),
            activeIcon: Icon(
              FontAwesomeIcons.solidUser,
              color: Color(0xFF488B66),
              size: 27.0,
            ),
            title: Text(
              'Tài khoản',
              style: TextStyle(
                  color: Color(0xFF488B66)
              ),
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        });
  }
}


