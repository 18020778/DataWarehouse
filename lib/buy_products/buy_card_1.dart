import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'choice_address_2.dart';

class buyCard extends StatefulWidget {
  @override
  _buyCardState createState() => _buyCardState();
}

class _buyCardState extends State<buyCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thanh toán",
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
        child: Column(
          children: [
            buyerAddress(),
            Container(
              height: 10,
              decoration: BoxDecoration(color: Colors.black12),
            ),
            listProducts(
                shopName: "ShopName",
                productName: "NameProduct",
                img: "assets/bonsai.jpg",
                price: "20000",
                amount: 3),
            choiceDeliver(),
            Container(
              height: 10,
              decoration: BoxDecoration(color: Colors.black12),
            ),
            paymentMethods(),
            Container(
              height: 50,
              decoration: BoxDecoration(color: Colors.black12),
            ),

          ],
        ),
        
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            boxShadow: [BoxShadow(
              offset: Offset(0, -5),
              blurRadius: 5,
              color: Color(0xFFDADADA).withOpacity(0.5),
            )]
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tổng thanh toán: ", style: TextStyle(fontSize: 18),),
                  Text("đ" + 35000.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,)),
                ],
              ),
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 17, horizontal: 25),
              color: Color(0xFF488B66),
              child: Text("Đặt hàng", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => buyCard()));
              },
            ),
          ],
        ),
      ),
    );
  }

  buyerAddress() {
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: screenWidth * 0.84,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/location.png",
                          width: 16,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "  Địa chỉ nhận hàng",
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 28, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nguyễn Hồng Lĩnh" + " | " + "06746576573",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Số 10, ngõ 1 Thiên Hiền",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Quận Nam Từ Liêm, Hà Nội",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ChoiceAddress()));
                },
                icon: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Image.asset(
            "assets/border.png",
            width: screenWidth,
            height: 5,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }

  listProducts(
      {String shopName,
      String productName,
      String img,
      String price,
      int amount}) {
    return Column(
      children: [
        Container(
          height: 35,
          decoration: BoxDecoration(
              color: Color(0xFFE6FFEE),
            boxShadow: [BoxShadow(
              color: Colors.grey,
          ),]),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Image.asset(
                  "assets/shop.png",
                  width: 25,
                  fit: BoxFit.cover,
                ),
                Text(
                  "  " + shopName,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                img,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.76,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "đ" + price,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          new Spacer(),
                          Text(
                            "x" + amount.toString(),
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  choiceDeliver() {
    var screenWidth = MediaQuery.of(context).size.width;
    return
        Column(
          children: [
            Container(
              height: 1,
              width: double.infinity,
              color: Color(0xFF488B66),
            ),
            Container(
            color: Color(0xFFE6FFEE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              FlatButton(
                child: Text("Đơn vị vận chuyển (Nhấn để chọn)", style: TextStyle(fontSize: 18, color: Color(0xFF488B66),),),
              onPressed: (){},),
                Container(
                  height: 1,
                  width: 380,
                  margin: EdgeInsets.only(left: (screenWidth-380)/2),
                  color: Colors.black54,
                ),
                SizedBox(height: 5,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: (screenWidth-380)/2),
                      width: screenWidth * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                              Text(
                                "Vận chuyển nhanh",
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, height: 1.5),
                              ),
                                Text(
                                  "Shopee Express",
                                  style: TextStyle(fontSize: 16, height: 1.5),
                                ),
                                Text(
                                  "Nhận hàng vào " + "15 Th04 - 17 Th04",
                                  style: TextStyle(fontSize: 15, color: Colors.black54, height: 1.5),
                                ),
                        ],
                      ),
                    ),
                   new Spacer(),
                   Row(
                      children: [
                        Text("đ" + "15000", style: TextStyle(fontSize: 16),),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Color(0xFF488B66),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Tổng số tiền (1 sản phẩm): ", style: TextStyle(fontSize: 17),),
                      new Spacer(),
                      Text("đ" + 35000.toString(), style: TextStyle(fontSize: 18, color: Color(0xFF488B66), fontWeight: FontWeight.w700),),
                    ],
                  ),
                )
    ]
    ),
            ),
          ],
        );
  }

  paymentMethods() {
    return
      Column(
        children: [
          Row(
            children: [
              FlatButton.icon(onPressed: (){},
                  icon: Icon(CupertinoIcons.money_dollar_circle_fill),
                  label: Text("Thanh toán sau khi nhận hàng", style: TextStyle(fontSize: 18))),
              /*Row(
                children: [
                  Text("Ví AirPay", style: TextStyle(fontSize: 17),),
                  Icon(Icons.arrow_forward_ios),
                ],
              )*/
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left:15.0, top: 5, right: 15, bottom: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Tổng tiền hàng", style: TextStyle(fontSize: 15, color: Colors.black54),),
                    Spacer(),
                    Text("đ" + 15000.toString(), style: TextStyle(fontSize: 16, color: Colors.black54))
                  ],
                ),

            Row(
              children: [
                Text("Tổng tiền phí vận chuyển", style: TextStyle(fontSize: 15, color: Colors.black54),),
                Spacer(),
                Text("đ" + 15000.toString(), style: TextStyle(fontSize: 16, color: Colors.black54))
              ],
            ),
            Row(
              children: [
                Text("Tổng thanh toán", style: TextStyle(fontSize: 18, color: Colors.black),),
                Spacer(),
                Text("đ" + 35000.toString(), style: TextStyle(fontSize: 18, color: Color(0xFF488B66)))
              ],
            ),
              ],
            ),
          ),
        ],
      );
  }
}
