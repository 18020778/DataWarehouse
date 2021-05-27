import 'package:first_app/models/transport.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Transport extends StatefulWidget {
  @override
  _TransportState createState() => _TransportState();
}

class _TransportState extends State<Transport>{
  String weight = '';
  bool enableFeature = false;
  whenCompleted(){
          if(this.weight!='') return true;
          return false;
  }
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF407C5A),
        iconTheme: IconThemeData(
          color: Colors.yellow,
        ),
        title:  Text(
          'Phí vận chuyển',
          style: TextStyle(color: Colors.yellow, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        actions: [
          FlatButton(
              onPressed: (){
                if(whenCompleted()==true){
                  Navigator.pop(context, new TransportProduct(this.weight, this.enableFeature));
                }
                else
                {
                  Fluttertoast.showToast(msg: "Vui lòng điền đầy đủ thông tin");
                }

              },
              child: Text(
                "Lưu",
                style: TextStyle(fontSize: 20, color: Colors.yellow),
              )
          ),

        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.add_shopping_cart_sharp),
                  Text(
                    'Cân nặng (g)',
                    style: TextStyle(fontSize: 23,),
                  ),
                  //
                  Expanded(
                    child: new TextField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.green,
                          hintText: 'gram',
                          hintStyle: TextStyle(color: Colors.green, decoration: TextDecoration.underline, fontSize: 20) ),
                      textDirection: TextDirection.rtl,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 20),
                      onChanged: (value){
                        this.weight = value;
                      },
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget> [
                  Icon(Icons.train),
                  Text(
                    ' Giao hàng nhanh',
                    style: TextStyle(fontSize: 23),
                  ),
                  new Spacer(),
                  Switch(
                      activeColor: Colors.green,
                      value: enableFeature,
                      onChanged: (enabled){
                        setState(() {
                          enableFeature = enabled;
                        });
                      }
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
