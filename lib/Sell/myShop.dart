

import 'dart:io';

import 'package:first_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'addProduct.dart';

class MyShop extends StatefulWidget {
  User user;
  @override
  _MyShopState createState() => _MyShopState();

  MyShop({this.user});
}

class _MyShopState extends State<MyShop>{
  String title='';
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF407C5A),
        iconTheme: IconThemeData(
          color: Color(0xFF407C5A),
        ),
        title: Text(
          'Shop của tôi',
          style: TextStyle(color: Colors.yellow, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: FlatButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProduct(user:widget.user)),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_box_rounded),
                    Expanded(
                      child:
                      Text(
                        ' Thêm sản phẩm',
                        style: TextStyle(fontSize: 23),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
