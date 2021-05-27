import 'package:flutter/material.dart';
import 'package:first_app/account/EditPhoneChange2.dart';

class EditPhone extends StatefulWidget {
  @override
  _EditPhoneState createState() => _EditPhoneState();
}

class _EditPhoneState extends State<EditPhone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: Text('Số điện thoại',
          style: TextStyle(fontSize: 22),),
        backgroundColor: Color(0xFF407C5A),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black12.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("0947384573845", style: TextStyle(fontSize: 19),),
                  FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => EditPhoneChange()));
                      },
                      child: Text("THAY ĐỔI", style: TextStyle(fontSize: 19, color: Color(0xFF407C5A)),))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO Implement this library.