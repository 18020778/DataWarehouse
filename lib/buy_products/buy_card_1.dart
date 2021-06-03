import 'dart:collection';

import 'package:first_app/buy_products/show_cart_0.dart';
import 'package:first_app/models/shippingInfor.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/my_orders/my_orders_screen.dart';
import 'package:first_app/services/purchase_service.dart';
import 'package:first_app/show_products_page/body_home_0.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'choice_address_2.dart';

class buyCard extends StatefulWidget {
  User user;
  List<Cart> listCard;
  @override
  _buyCardState createState() => _buyCardState();
  buyCard(this.user, this.listCard);
}

class _buyCardState extends State<buyCard> {
 String userNameShop;
 shippingInfor  item;
  List<String> nameShop = new List();
  List<Map> listTotalMoney = new List();
  var totalMoney = 0;
  var totalMoneyPayForProduct = 0;
  var totalMoneyPayForShip = 0;
  var name = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      this.userNameShop =  widget.listCard[0].shop.userName;
      if(widget.user.listShippingInfor.isNotEmpty)
      this.item = widget.user.listShippingInfor.last;
    });
    widget.listCard.forEach((element) {
      nameShop.add(element.shop.userName);
    });
   name = nameShop.toSet().toList();

   name.forEach((element) {
     var totalMoneyPayForCurrentShop  =  0;
     var feeShip  = 0;
     widget.listCard.forEach((product) {
       if(product.shop.userName == element){
         totalMoneyPayForCurrentShop  += product.amount *  int.parse(product.price);
       }
     });
     if(totalMoneyPayForCurrentShop  < 100000) feeShip = 15000;
     totalMoneyPayForProduct += totalMoneyPayForCurrentShop;
     totalMoneyPayForShip += feeShip;
     var shop = {'shopName' : element, 'totalMoney':  totalMoneyPayForCurrentShop, 'feeShip': feeShip};
     listTotalMoney.add(shop);
   });
   totalMoney = totalMoneyPayForShip +  totalMoneyPayForProduct;

  }
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
            // chon cac san pham nay
           Container(
             child: Column(
               children: [
                 for(int i = 0; i< widget.listCard.length; i++)
                     listProducts(shop: widget.listCard[i].shop, productName: widget.listCard[i].nameProduct, img: widget.listCard[i].img, price: widget.listCard[i].price, amount: widget.listCard[i].amount),
                  choiceDeliver(widget.listCard[0].shop.userName)
               ],
             )
             ,
           ),
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
                  Text("Tổng thanh toán: ", style: TextStyle(fontSize: 17),),
                  Text(totalMoney.toString()+'d', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700,)),
                ],
              ),
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
              color: Color(0xFF488B66),
              child: Text("Đặt hàng", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
              onPressed: () {
                if(item==null){
                  Fluttertoast.showToast(msg: "Vui lòng chọn địa chỉ nhận hàng");
                }
                else {
                  widget.listCard.forEach((element) {
                    PurchaseService().buyProducts(widget.user.uid, item.uid, element.img, element.price,element.productID,  element.nameProduct, element.shop.uid, element.amount, element.amount*int.parse(element.price) );
                    PurchaseService().deteleItemInCart(widget.user.uid, element.productID);
                  });
                  Fluttertoast.showToast(msg: "Đặt hàng thành công. ");
                  Future.delayed(const Duration(seconds: 2), (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrdersScreen(user: widget.user,)));
                  });
                  // laf toi man hinh home

                }

              },
            ),
          ],
        ),
      ),
    );
  }

  // in the end of class by card
  buyerAddress() {
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: screenWidth * 0.8,
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
                          (widget.user.listShippingInfor.length > 0) ?
                          Column(
                            children: [
                              Text(
                                item.name + " | " + item.phoneNumber,
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                               item.address.toString(),
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ) : Text("Thêm địa chỉ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ChoiceAddress(user: widget.user,))).then((value){
                        if(value!=null)
                        setState(() {
                          this.item = value;
                        });
                  });
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
      {User shop,
      String productName,
      String img,
      String price,
      int amount})
  {
    return  Column(
       children: [
        (shop.userName!=userNameShop) ?
        choiceDeliver(shop.userName) : SizedBox(height: 0,),
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
                  "  " + shop.userName,
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
              Image.network(
                img,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.72,
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
    ) ;

  }

  choiceDeliver(String shopName) {
    var totalMoney = 0;
    var feeShip = 0;
    this.listTotalMoney.forEach((element) {
      if(element['shopName'] == this.userNameShop){
        totalMoney= element['totalMoney'];
        feeShip = element['feeShip'];
      }
    });
    setState(() {
      this.userNameShop =shopName;
    });
    var screenWidth = MediaQuery.of(context).size.width;


       return Column(
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
              // FlatButton(
              //   child: Text("Đơn vị vận chuyển Express)", style: TextStyle(fontSize: 18, color: Color(0xFF488B66),),),
              // onPressed: (){},),
                SizedBox(height: 8,),
                // Container(
                //   height: 1,
                //   width: 380,
                //   color: Colors.black54,
                // ),
                // SizedBox(height: 5,
                // ),
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                              Text(
                                "Số tiền: ",
                                style: TextStyle(fontSize: 15, height: 1.5),
                              ),
                                Text(
                                  "Phí ship: ",
                                  style: TextStyle(fontSize: 15, height: 1.5),
                                ),
                                Text(
                                  "Tổng số tiền: ",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, height: 1.5),
                                ),
                        ],
                      ),
                    ),
                   new Spacer(),
                   Row(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(totalMoney.toString()+"d", style: TextStyle(fontSize: 15, height: 1.5),),
                              Text(feeShip.toString() + 'd', style: TextStyle(fontSize: 15, height: 1.5),),
                              Text((totalMoney + feeShip).toString()+ 'd', style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700, height: 1.5),),
                            ],
                          ),
                        )

                      ],
                    ),
                  ],
                ),

                SizedBox(height: 10,)
                // SizedBox(height: 5,),
                // Container(
                //   height: 1,
                //   width: double.infinity,
                //   color: Color(0xFF488B66),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Text("Tổng số tiền (1 sản phẩm): ", style: TextStyle(fontSize: 17),),
                //       new Spacer(),
                //       Text("đ" + 35000.toString(), style: TextStyle(fontSize: 18, color: Color(0xFF488B66), fontWeight: FontWeight.w700),),
                //     ],
                //   ),
                // )
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
                    Text(totalMoneyPayForProduct.toString()  +'d', style: TextStyle(fontSize: 16, color: Colors.black54))
                  ],
                ),

            Row(
              children: [
                Text("Tổng tiền phí vận chuyển", style: TextStyle(fontSize: 15, color: Colors.black54),),
                Spacer(),
                Text( totalMoneyPayForShip.toString()+'d', style: TextStyle(fontSize: 16, color: Colors.black54))
              ],
            ),
            Row(
              children: [
                Text("Tổng thanh toán", style: TextStyle(fontSize: 18, color: Colors.black),),
                Spacer(),
                Text(totalMoney.toString()+'d', style: TextStyle(fontSize: 18, color: Color(0xFF488B66)))
              ],
            ),
              ],
            ),
          ),
        ],
      );
  }
}
