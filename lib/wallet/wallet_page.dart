import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(children: [
        Container(
          height: screenHeight*0.45,
          child: Stack(
              children: [
            Column(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.37,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(4281755726), Color(0xFF488B66)],
                    ),
                  ),
                  child: Column(children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text('Tổng tiền trong Ví',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white70,
                            height: 1.5)),
                    Text(
                      "đ " + 36000.toString(),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Số dư Ví",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                )),
                            Text("đ" + 36000.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Ví thưởng ?",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                )),
                            Text("đ" + 0.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ],
            ),
            Positioned(
                top: 230,
                left: (screenWidth - 360) / 2,
                child: Container(
                  width: 360,
                  height: 85,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black38, blurRadius: 5, spreadRadius: 1)
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100,
                        child: FlatButton(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Image.asset(
                                "assets/addWallet.png",
                                width: 42,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "Nạp tiền",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        child: FlatButton(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Image.asset(
                                "assets/viewCard.png",
                                width: 43,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                'Tài khoản',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black87),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        child: FlatButton(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 3,
                              ),
                              Image.asset(
                                "assets/add_card.png",
                                width: 45,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                'Thêm tài khoản',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black87),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ]),
        ),
        SizedBox(height: 10,),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.only(left: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Lịch sử thanh toán",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 7,
                  ),

                  Column(
                    children: [
                      Container(
                        height: 2,
                        width: screenWidth,
                        decoration: BoxDecoration(color: Colors.black38),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/cay_trong_nha.jpg",
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 210,
                                    child: Text(
                                      "NameProduct vis du cay lan phap",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 19),
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Text(
                                    "20-04-2021",
                                    style: TextStyle(fontSize: 16, color: Colors.black54),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            Text("đ" + 2000000.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Container(
                    height: 2,
                    width: screenWidth,
                    decoration: BoxDecoration(color: Colors.black38),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
