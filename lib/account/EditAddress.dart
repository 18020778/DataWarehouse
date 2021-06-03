import 'package:flutter/material.dart';

class EditAddress  extends StatefulWidget {
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  String newAddress = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF407C5A), //change your color here
        ),
        title: Text("Địa chỉ shop", style: TextStyle(color: Colors.black, fontSize: 22),),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: (){
                Navigator.pop(context, this.newAddress);
              },
              child: Text("Lưu", style: TextStyle( fontSize: 20, color: Color(0xFF407C5A)),)),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black12.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Theme(
              data: new ThemeData(
                primaryColor: Colors.grey,
                primaryColorDark: Colors.grey,
              ),
              child: TextField(
                style: TextStyle(fontSize: 20.0),
                decoration: InputDecoration(contentPadding: EdgeInsets.all(8),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Địa chỉ",
                  hintStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                onChanged: (value){
                  this.newAddress = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
