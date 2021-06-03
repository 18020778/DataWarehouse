import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/buy_products/buy_card_1.dart';
import 'package:first_app/buy_products/choice_address_2.dart';
import 'package:first_app/buy_products/choose_map_4.dart';
import 'package:first_app/buy_products/wemap_chooseAddress.dart';
import 'package:first_app/models/shippingInfor.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddAddress extends StatefulWidget {
  User user;

  AddAddress({Key key, this.user}) : super(key: key);
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  String userName='';
  String phoneNumber='';
  String address='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Thêm địa chỉ",
            style: TextStyle(fontSize: 21),
          ),
          centerTitle: true,
          toolbarHeight: 65,
          flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(4281755726), Color(0xFF488B66)],
                ),
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
              height: 1000,
              decoration: BoxDecoration(
                color: Color(0xFFDADADA).withOpacity(0.5),
              ),
              child: Column(children: [
                SizedBox(height: 2,),
                Container(
                    decoration: BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(children: [
                      Flexible(
                          child: TextField(
                            style: TextStyle(color: Colors.black54, fontSize: 18),
                            onChanged: (value){
                              setState(() {
                                this.userName = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nhập họ tên"
                            ),
                          ))
                    ])),
                SizedBox(height: 2,),
                Container(
                    decoration: BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(children: [
                      Flexible(
                          child: TextField(
                            style: TextStyle(color: Colors.black54, fontSize: 18),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nhập số"
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              setState(() {
                                this.phoneNumber = value;
                              });
                            },
                          ))
                    ])),
                SizedBox(height: 2,),
                Container(
                    decoration: BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(children: [
                      Flexible(
                          child: TextField(
                            controller: TextEditingController(text: this.address),
                            style: TextStyle(color: Colors.black54, fontSize: 18),
                            decoration: InputDecoration(
                              border: InputBorder.none,

                              hintText: "Nhập điạ chỉ",
                            ),
                            onChanged: (value){
                              setState(() {
                               this.address = value;
                              });
                            },
                          ))
                    ])),
                SizedBox(height: 15,),
                FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FullMap())).then((value){
                        if(value!=null)
                        setState(() {
                          this.address = value;
                        });
                      });
                    },
                    color: Colors.white,
                    child: Row(
                      children: [
                        Image.asset("assets/location.png", height: 30, width: 20, fit: BoxFit.cover,),
                        SizedBox(width: 13,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Chọn vị trí trên bản đồ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                            Text("Giúp vị trí được xác định nhanh nhất", style: TextStyle(fontSize: 17, color: Colors.black54),),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    )),
                SizedBox(height: 15,),
                SizedBox(height: 25,),
                FlatButton(onPressed: () async {
                  String documentId='';
                  if(this.address!=''&&this.userName!=''&&this.phoneNumber!=''){
                    documentId = await Database().addAddress(widget.user.getUid(), this.address, this.phoneNumber, this.userName);
                  }else{
                    Fluttertoast.showToast(msg: "Xin vui lòng điền đầy đủ thông tin!!! ");
                  }
                  shippingInfor newAdd = new shippingInfor(documentId, this.address, this.phoneNumber, this.userName);
                  Navigator.pop(context, newAdd);
                },
                  padding: EdgeInsets.all(15),
                  minWidth: 410,
                  child: Text("CHỌN ĐỊA CHỈ", style: TextStyle(color: Colors.white, fontSize: 18),),
                  color: Color(0xFF488B66),
                )
              ])),
        ));
  }
}
