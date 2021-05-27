import 'package:first_app/models/specifcation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Specification extends StatelessWidget {
  String age;
  String origin;
  String temperature ;
  String theAmountOfWater;
  var _controller = TextEditingController();
  whenCompleted(){
    if(this.age != null && this.theAmountOfWater != null && this.origin != null && this.temperature != null){
      return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF407C5A),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title:  Text(
          'Đặc tả',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        actions: [
          FlatButton(
              onPressed: (){
                if(whenCompleted()){
                  Navigator.pop(context, new SpecificationProduct(this.age, this.origin,  this.temperature, this.theAmountOfWater));
                }
                else
                  {
                    Fluttertoast.showToast(msg: "Vui lòng điền đầy đủ thông tin");
                  }
                //addProduct().whenComplete(() => Navigator.of(context).pop());,
              },
              child: Text(
                "Lưu",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
          ),

        ],
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.access_time),
                  Text(
                    ' Tuổi thọ ',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                  //
                  Expanded(
                    child: new TextField(
                      textAlign: TextAlign.right,
                      controller: _controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Nhập ',
                          hintStyle: TextStyle(color: Colors.green, fontSize: 18) ),
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 20),
                      onChanged: (value){
                        this.age = value;
                      },

                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.ac_unit_rounded),
                  Text(
                    ' Xuất xứ ',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                  //
                  Expanded(
                    child: new TextField(
                      textAlign: TextAlign.right,
                      onChanged: (value){
                        this.origin = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.green,
                          hintText: 'Nhập ',
                          hintStyle: TextStyle(color: Colors.green, fontSize: 18) ),

                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Icon(Icons.wb_twighlight),
            //       Text(
            //         ' Điều kiện chăm sóc',
            //         style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            //       ),
            //       //
            //       SizedBox(
            //         height: 10,
            //       ),
            //
            //       // Expanded(
            //       //   child: new TextField(
            //       //     textAlign: TextAlign.right,
            //       //     onChanged: (value){
            //       //       this.careConditions = value;
            //       //     },
            //       //     decoration: InputDecoration(
            //       //         border: OutlineInputBorder(
            //       //           borderRadius: BorderRadius.circular(10.0),
            //       //           borderSide: BorderSide.none,
            //       //         ),
            //       //         fillColor: Colors.green,
            //       //         hintText: 'Nhập ',
            //       //         hintStyle: TextStyle(color: Colors.green, fontSize: 18) ),
            //       //
            //       //     style: TextStyle(fontSize: 20),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            // Padding(padding:const EdgeInsets.all(8.0),
            // child: Row(
            //   children: [
            //     Expanded(child: TextField(
            //       textAlign: TextAlign.left,
            //       decoration: InputDecoration(
            //           filled: true,
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10.0),
            //             borderSide: BorderSide(
            //               color: Color(0xFF407C5A),
            //             ),
            //           ),
            //           //errorText: 'Bắt buộc phải nhập',
            //           hintText: 'Nhập tại đây ',
            //           hintStyle: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.w500) ),
            //       style: TextStyle(fontSize: 20),
            //       maxLines: 6,
            //       onChanged: (text){
            //        this.careConditions = text;
            //       },
            //
            //     ),)
            //   ],
            // )),
            // SizedBox(
            //   height: 10,
            // ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.adjust),
                  Text(
                    "Nhiệt độ ",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                  //
                  Expanded(
                    child: new TextField(
                      textAlign: TextAlign.right,
                      onChanged: (value){
                        this.temperature = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.green,
                          hintText: 'Nhập ',
                          hintStyle: TextStyle(color: Colors.green, fontSize: 18) ),

                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.ac_unit_rounded),
                  Text(
                    'Hàm lượng nước',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                  //
                  Expanded(
                    child: new TextField(
                      textAlign: TextAlign.right,
                      onChanged: (value){
                        this.theAmountOfWater = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.green,
                          hintText: 'Nhập ',
                          hintStyle: TextStyle(color: Colors.green, fontSize: 18) ),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),


            // Padding(
            //     padding:const EdgeInsets.all(8.0),
            //     child: Column(
            //         children: [
            //           Row(
            //             children:[
            //                 Icon(Icons.access_alarms),
            //                 Text(
            //                   ' Thời gian chăm sóc ',
            //                     style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            //                 ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: 20,
            //           ),
            //           TextField(
            //             textAlign: TextAlign.left,
            //             decoration: InputDecoration(
            //                 filled: true,
            //                 border: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(10.0),
            //                   borderSide: BorderSide(
            //                     color: Color(0xFF407C5A),
            //                   ),
            //                 ),
            //
            //                 hintText: '',
            //                 hintStyle: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.w500) ),
            //                 style: TextStyle(fontSize: 20),
            //                 maxLines: 6,
            //                 onChanged: (text){
            //
            //                     },
            //
            //           ),
            //         ]
            //     ),
            // ),

          ],
        ),
      ),
    );
  }

}
