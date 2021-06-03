import 'package:first_app/buy_products/choice_address_2.dart';

import 'package:first_app/buy_products/wemap_chooseAddress.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/database.dart';
import 'package:flutter/material.dart';

class EditAddress extends StatefulWidget {
  User user;
  String name;
  String sdt;
  String diachi;
  String documentID;
  EditAddress({Key key, this.name, this.sdt, this.diachi,this.documentID, this.user}) : super(key: key);
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  String address;
  String username;
  String phoneNumber;
  initState(){
    super.initState();
     address = widget.diachi;
     username = widget.name;
     phoneNumber = widget.sdt;
  }

  @override
  Widget build(BuildContext context) {

    _showAlertDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Bạn chắc chắn xóa?"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Database().deleteDeliver(widget.user.uid, widget.documentID);
                      var index = widget.user.listShippingInfor.indexWhere((element) => element.uid==widget.documentID);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.pop(context, index);
                    },
                    child: Text(
                      "Xóa",
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Sửa địa chỉ",
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
                    Text(
                      "Họ tên",
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Flexible(
                        child: TextField(
                          textAlign: TextAlign.end,
                      controller: TextEditingController(text: widget.name),
                      style: TextStyle(color: Colors.black54, fontSize: 18),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                          onChanged: (value){
                            this.username= value;
                          },
                    ))
                  ])),
              SizedBox(height: 2,),
              Container(
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(children: [
                    Text(
                      "Số điện thoại",
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Flexible(
                        child: TextField(
                          textAlign: TextAlign.end,
                          controller: TextEditingController(text: widget.sdt),
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value){
                            this.phoneNumber= value;
                          },
                        ))
                  ])),
              SizedBox(height: 2,),
              Container(
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(children: [
                    Text(
                      "Địa chỉ",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 10,),
                    Flexible(
                        child: TextField(
                          textAlign: TextAlign.end,
                          controller: TextEditingController(text: widget.diachi),
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value){
                            this.address= value;
                          },
                        ))
                  ])),
              SizedBox(height: 15,),
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FullMap()));
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
              Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white
                ),
              child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  onPressed: (){
                    _showAlertDialog(context);
                  },
                  color: Colors.white,
                  child: Text("Xóa địa chỉ",style: TextStyle(fontSize: 18, color: Color(0xFF488B66)),),
                  ),),
              SizedBox(height: 25,),
              FlatButton(onPressed: (){
                //sửa database thành true nếu ng dùng chọn
                Database().updateDAddress(widget.user.getUid(),widget.documentID,  this.address, this.phoneNumber, this.username);
                print(widget.documentID);
                widget.user.listShippingInfor.forEach((element) {
                  if(element.uid==widget.documentID){
                    element.address = this.address;
                    element.phoneNumber = this.phoneNumber;
                    element.name = this.username;
                  }
                });
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChoiceAddress(user: widget.user,)));
              },
                padding: EdgeInsets.all(15),
                minWidth: 410,
                child: Text("SỬA ĐỊA CHỈ", style: TextStyle(color: Colors.white, fontSize: 18),),
                color: Color(0xFF488B66),
              )
            ])),
    ));
  }
}
