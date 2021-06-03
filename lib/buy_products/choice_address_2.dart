import 'package:first_app/buy_products/addAddress.dart';
import 'package:first_app/buy_products/buy_card_1.dart';
import 'package:first_app/models/shippingInfor.dart';
import 'package:first_app/models/user.dart';
import 'package:flutter/material.dart';
import 'addAddress.dart';
import 'edit_address_3.dart';

class ChoiceAddress extends StatefulWidget {
  User user;
  @override
  _ChoiceAddressState createState() => _ChoiceAddressState();
  ChoiceAddress({this.user});
}

class _ChoiceAddressState extends State<ChoiceAddress> {
  var chose = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Địa chỉ",
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
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
            child: Column(
              children: [
                for(int i = 0; i< widget.user.listShippingInfor.length; i++)
                  AddressItem(chose: false, name: widget.user.listShippingInfor[i].name,
                  sdt: widget.user.listShippingInfor[i].phoneNumber,
                  diachi: widget.user.listShippingInfor[i].address,
                  documentID: widget.user.listShippingInfor[i].uid,
                  user: widget.user,),
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAddress(user: widget.user))).then((value){
                                if(value!=null)
                                setState(() {
                                  widget.user.listShippingInfor.add(value);
                                });
                      });
                    },
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        Text(
                          "Thêm địa chỉ mới",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}

class AddressItem extends StatefulWidget {
  bool chose;
  String name;
  String sdt;
  String diachi;
  String documentID;
  User user;
  AddressItem({Key key, this.chose, this.name, this.sdt, this.diachi,this.documentID,  this.user})
      : super(key: key);
  @override
  _AddressItemState createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> {
  @override
  Widget build(BuildContext context) {
    _showChoiceDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Chọn làm địa chỉ giao hàng"),
              actions: [
                FlatButton(
                    onPressed: () {
                      setState(() {
                        widget.chose = true;
                      });
                      shippingInfor item = widget.user.listShippingInfor.firstWhere((element) => element.uid == widget.documentID);
                      Navigator.pop(context);
                      Navigator.pop(context, item);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            );
          });
    }

    return Column(children: [
      Container(
          child: FlatButton(
        onPressed: () {
          _showChoiceDialog(context);
        },
        color: widget.chose ? Color(0xFFE6FFEE) : Colors.white,
        padding: EdgeInsets.only(left: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/location.png",
                  width: 20,
                  fit: BoxFit.cover,
                ),
                Text(
                  "  " + widget.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                Spacer(),
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              settings: RouteSettings(name: "/choiceAddress"),
                              builder: (context) => EditAddress(
                                  name: widget.name,
                                  sdt: widget.sdt,
                                  diachi: widget.diachi,
                              documentID : widget.documentID,
                              user: widget.user,)));
                    },
                    child: Text(
                      "Sửa",
                      style: TextStyle(color: Color(0xFF488B66), fontSize: 17),
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.sdt,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    widget.diachi,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
     SizedBox(height: 10),
    ]);
  }
}
