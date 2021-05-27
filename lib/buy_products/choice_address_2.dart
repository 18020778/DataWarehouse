import 'package:flutter/material.dart';

import 'edit_address_3.dart';

class ChoiceAddress extends StatefulWidget {
  @override
  _ChoiceAddressState createState() => _ChoiceAddressState();
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
                AddressItem(
                    chose: true,
                    name: "Nguyễn Hồng Lĩnh",
                    sdt: "08475384",
                    diachi: "So 10, ngõ 1 Thiên Hiền, Mỹ Đình, Hà Nội"),
                AddressItem(
                    chose: false,
                    name: "Nguyễn Hồng Lĩnh",
                    sdt: "08475384",
                    diachi: "So 10, ngõ 1 Thiên Hiền, Mỹ Đình, Hà Nội"),
                AddressItem(
                    chose: false,
                    name: "Nguyễn Hồng Lĩnh",
                    sdt: "08475384",
                    diachi: "So 10, ngõ 1 Thiên Hiền, Mỹ Đình, Hà Nội"),
                FlatButton(
                    onPressed: () {},
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

  AddressItem({Key key, this.chose, this.name, this.sdt, this.diachi})
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
                      Navigator.of(context).pop();
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
                              builder: (context) => EditAddress(
                                  name: widget.name,
                                  sdt: widget.sdt,
                                  diachi: widget.diachi)));
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
