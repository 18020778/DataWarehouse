
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/buy_products/buy_card_1.dart';
import 'package:first_app/login_reg_pages/loading.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/database.dart';
import 'package:first_app/services/purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cart {
   User shop;
   String img;
   String nameProduct;
   String price;
   int amount;
   bool checkBox = false;
   String productID;
  void setUser(User user){
    this.shop = user;
  }
  Cart({this.shop, this.img, this.nameProduct, this.price, this.amount, this.productID});
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    img : json['imageUrl'],
    nameProduct: json['productName'],
    price: json['price'],
    amount: json['amount'],
    productID: json['productID']
  );
}

class showCart extends StatefulWidget {
  User user;
  @override
  _showCartState createState() => _showCartState();
  showCart(this.user);
}

class _showCartState extends State<showCart> {
  static List<bool> listCheckBox = new List();
  bool viewResult = false;
  List<Cart> listCart = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var count = 0;
    PurchaseService().getAllProductInCart(widget.user.uid).then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty){
        count =  docs.documents.length;
        docs.documents.forEach((element) {
          Cart cart = Cart.fromJson(element.data);
          Database().getUserInfo(element.data['shopID']).then((value){
            if(value!=null)
            cart.setUser(value);
            listCart.add(cart);
            listCheckBox.add(false);
            if(listCart.length == count ){
              setState(() {
                this.viewResult = true;
              });
            }
          });

        });

      }
      else {
        setState(() {
          this.viewResult  = true;
        });
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    List<Cart> listCartHasBeenSelected = new List();
    bool _isDisable = true;
    return this.viewResult ? StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          var totalMoney =0;
      listCart.forEach((element) {
       if(element.checkBox){
         totalMoney += int.parse(element.price)*element.amount;
       }

      });

      return Scaffold(
        appBar: AppBar(
            toolbarHeight: 60,
            title: Text(
              "Giỏ hàng",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 25),
            ),
            centerTitle: true,
            elevation: 0.0,
            bottomOpacity: 0.0,
            flexibleSpace: Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(4281755726), Color(0xFF488B66)],
              ),
            )),
              actions: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.bell,
                    color: Colors.white,
                    size: 27.0,
                  ),
                  onPressed: () {},
                )
              ]),
          body: SingleChildScrollView(
            child: Stack(
                children: [
                  Container(
                    height: 205.0*listCart.length,
                    child: Column(
                      children: [
                   for(int i=0; i<listCart.length;i++)
                     Column(
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: [
                           Container(
                               margin: EdgeInsets.only(bottom: 30),
                               child: Column(children: [
                                 ColoredBox(
                                   color: Color(0xFFE6FFEE),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       FlatButton(
                                         onPressed: () {},
                                         child: Row(
                                           children: [
                                             Text(
                                               listCart[i].shop.userName,
                                               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                                             ),
                                             Icon(Icons.arrow_forward_ios),
                                           ],
                                         ),
                                       ),
                                       FlatButton(
                                           onPressed: () {
                                             PurchaseService().deteleItemInCart(widget.user.uid, listCart[i].productID);
                                             setState((){
                                               listCart.removeAt(i);
                                             });

                                           },
                                           child: Text(
                                             "Xóa",
                                             style: TextStyle(color: Colors.black54, fontSize: 16),
                                           ))
                                     ],
                                   ),
                                 ),
                                 Row(children: [
                                   Checkbox(
                                     value: listCart[i].checkBox,
                                     onChanged: (bool value) {
                                       setState(() {
                                         listCart[i].checkBox = value;
                                         if (listCart[i].checkBox) totalMoney += int.parse(listCart[i].price)*listCart[i].amount;
                                       });
                                       setState((){
                                         _isDisable =true;
                                       });
                                       listCart.forEach((element) {

                                         if(element.checkBox){
                                           setState((){
                                             _isDisable = false;
                                           });

                                         }
                                       });
                                     },
                                     activeColor: Color(0xFF488B66),
                                     checkColor: Colors.white,
                                   ),
                                   Image.network(
                                     listCart[i].img,
                                     height: 100 ,
                                     fit: BoxFit.cover,
                                   ),
                                   Container(
                                     margin: EdgeInsets.only(left: 20),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                           listCart[i].nameProduct,
                                           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                                           overflow: TextOverflow.ellipsis,
                                           maxLines: 1,
                                         ),
                                         Text(
                                           "đ" + listCart[i].price.toString(),
                                           style: TextStyle(color: Color(0xFF488B66), fontSize: 16),
                                         ),
                                         SizedBox(
                                           height: 10,
                                         ),
                                         Row(
                                           children: [
                                             ButtonTheme(
                                               minWidth: 50,
                                               child: OutlineButton(
                                                 onPressed: () {
                                                   setState(() {
                                                     while (listCart[i].amount > 0) {
                                                       listCart[i].amount--;
                                                     }
                                                   });
                                                 },
                                                 child: Text(
                                                   "-",
                                                   style: TextStyle(fontWeight: FontWeight.w700),
                                                 ),
                                               ),
                                             ),
                                             ButtonTheme(
                                                 minWidth: 50,
                                                 child: OutlineButton(
                                                   onPressed: null,
                                                   child: Text(
                                                     listCart[i].amount.toString(),
                                                     style: TextStyle(fontWeight: FontWeight.w700),
                                                   ),
                                                 )),
                                             ButtonTheme(
                                               minWidth: 50,
                                               child: OutlineButton(
                                                 onPressed: () {
                                                   setState(() {
                                                     listCart[i].amount++;
                                                   });
                                                 },
                                                 child: Text(
                                                   "+",
                                                   style: TextStyle(
                                                       fontWeight: FontWeight.w700, fontSize: 18),
                                                 ),
                                               ),
                                             ),
                                           ],
                                         )
                                       ],
                                     ),
                                   ),
                                 ])
                               ])),
                           Container(
                             height: 10,
                             decoration: BoxDecoration(
                                 color: Colors.black12
                             ),
                           )
                         ])
                    ]),
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
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -5),
                  blurRadius: 5,
                  color: Color(0xFFDADADA).withOpacity(0.5),
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tổng tiền: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text("đ" + totalMoney.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 17),
                color: Color(0xFF488B66),
                child: Text("Mua hàng", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                onPressed: _isDisable ? null : () {

                  // change to list cart
                  listCart.forEach((element) {
                    if(element.checkBox){
                      listCartHasBeenSelected.add(element);
                    }
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => buyCard(widget.user, listCartHasBeenSelected)));
                },
              ),
            ],
          ),
        ),
      );
    }) : Loading();
  }
}
