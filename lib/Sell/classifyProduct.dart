import 'package:flutter/material.dart';


class ClassifyProduct extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF407C5A),
        ),
        title:  Text(
          'Phân loại hàng',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        centerTitle: true,
        /* actions: [
             FlatButton(
                 onPressed:(){
                   widget.
                 },
                 child: Text(
                   "Lưu",
                   style: TextStyle(fontSize: 20, color: Color(0xFF407C5A)),
                 )),
           ],*/
      ),
    );
  }

}
