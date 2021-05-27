import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_app/account/EditPhoneOTP_3.dart';

class EditPhoneChange extends StatefulWidget {
  @override
  _EditPhoneChangeState createState() => _EditPhoneChangeState();
}

class _EditPhoneChangeState extends State<EditPhoneChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: Text('Số điện thoại mới',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Vui lòng nhập số điện thoại mới để nhận được mã OTP", style: TextStyle(color: Colors.black54, fontSize: 18),),
            ),
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
                    hintText: "Số điện thoại",
                    hintStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  )
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width-20,
              decoration: BoxDecoration(
                color: Color(0xFF407C5A),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FlatButton(
                color: Color(0xFF407C5A),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => phoneOTP()));
                },
                child: Text("Tiếp tục", style: TextStyle(color: Colors.white, fontSize: 18),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
