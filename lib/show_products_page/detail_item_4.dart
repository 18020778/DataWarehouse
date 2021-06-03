import 'package:first_app/buy_products/show_cart_0.dart';
import 'package:first_app/login_reg_pages/loading.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/likeProduct.dart';
import 'package:first_app/services/purchase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_pro/carousel_pro.dart';

class DetailItem extends StatefulWidget {
  Product product;
  User user;
  @override
  _DetailItemState createState() => _DetailItemState();

  DetailItem({this.product, this.user});
}
class _DetailItemState extends State<DetailItem> {
  bool isFavorited= false;
  bool viewResult = false;
  @override
  void initState() {
    // xem xem cais nayf minhf cos like hay khong
    likeProduct().isLiked(widget.user.uid, widget.product.productID).then((value){
      if(value!=null)
      setState(() {
        this.isFavorited = value;
        this.viewResult=true;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    var setImage = isFavorited
        ? Image.asset(
      'assets/heart_like.png',
      width: 25,
    )
        : Image.asset(
      'assets/heart.png',
      width: 25,
    );

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return (this.viewResult) ?  Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            widget.product.productName.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
                fontFamily: "Merriweather",
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
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
          icon: (setImage),
        onPressed: () {
          setState(() {
            this.isFavorited = !this.isFavorited;
          });

          if(this.isFavorited){
            likeProduct().addFavoriteProduct(widget.user.getUid(), widget.product.productID);
          }else{
            likeProduct().deleteFavoriteProduct(widget.user.getUid(), widget.product.productID);
          }
        }),
          ]),
      body: Container(
          child: Stack(children: <Widget>[
        Column(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight * 0.46,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF488B66), Color(4284859275)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color(4291751385),
                        offset: Offset(0, 20),
                        spreadRadius: 4,
                        blurRadius: 20.0),
                  ]),
              child: _appBarDetail(context),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Cách chăm sóc",
                  style: TextStyle(
                    fontFamily: "Merriweather",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.product.takeCareOfTree.toString(),
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 15,
          child: Row(
            children: <Widget>[
              Container(
                width: screenWidth * 0.5,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Đặc tả",
                        style: TextStyle(
                          fontFamily: "Merriweather",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Tuổi thọ: " + widget.product.longevity.toString(),
                          style: TextStyle(fontSize: 16, height: 1.5),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Xuất xứ: " + widget.product.origin.toString(),
                          style: TextStyle(fontSize: 16, height: 1.5),
                        )),
                    // Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Text(
                    //       "Thời gian chăm sóc: " + "nhiều",
                    //       style: TextStyle(fontSize: 16, height: 1.5),
                    //     )),
                    /*Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ngày trồng: " + "20/10/2020",
                          style: TextStyle(fontSize: 16, height: 1.5),
                        )),*/
                  ],
                ),
              ),
              Container(
                width: screenWidth * 0.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF488B66), Color(4284859275)],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Row(
                      //   children: [
                      //     Image.asset(
                      //       "assets/sun.png",
                      //       width: 35,
                      //       height: 35,
                      //     ),
                      //     Text(
                      //       "  " + widget.product.,
                      //       style: TextStyle(color: Colors.white, fontSize: 16),
                      //     )
                      //   ],
                      // ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/droplet.png",
                              width: 30,
                              height: 30,
                            ),
                            Text(
                              "  " + widget.product.theAmountOfWater.toString() + " ml",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/temperature.png",
                            width: 40,
                            height: 40,
                          ),
                          Text(
                            " " + widget.product.temperature.toString()+ " °C",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ])),
    ) : Loading();
  }

  Widget _appBarDetail(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
        child: Row(children: [
      Container(
          width: screenWidth * 0.39,
          margin: EdgeInsets.only(right: 8.2),
          child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Giá",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white70),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.product.price.toString() + " đ",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Chiều cao",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white70),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.product.height.toString() + " cm",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Thể loại",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white70),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                            widget.product.category.toString(),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 8,),

                          Column(
                              children: [
                            Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: RaisedButton(
                                textColor: Colors.black,
                                color: Colors.white,
                                child: Text(
                                  'Mua ngay',
                                  style: TextStyle(fontSize: 16),
                                ),


                                onPressed: () {
                                  PurchaseService().addProductToTheCart(widget.product.productID, 1, widget.user.uid, widget.product.accountID, widget.product.listImage.last, widget.product.productName, widget.product.price);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => showCart(widget.user)));
                                },
                                splashColor: Colors.black,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            Container(
                              child: Row(children: <Widget>[
                                FlatButton(
                                  minWidth: 70,
                                  padding: EdgeInsets.all(2.0),
                                  color: Colors.white,
                                      child: Image.asset(
                                        "assets/message.png",
                                        width: 40,
                                        fit: BoxFit.cover,
                                      ),
                                      onPressed: () {},
                                    ),
                                    FlatButton(
                                      minWidth: 60,
                                      color: Colors.white,
                                      child: Image.asset(
                                        "assets/addToCart.png",
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                      onPressed: () {
                                        // adding product to them cart
                                        PurchaseService().addProductToTheCart(widget.product.productID, 1, widget.user.uid, widget.product.accountID, widget.product.listImage.last, widget.product.productName, widget.product.price);
                                        // Announcement of adding products to the cart
                                        showAlert(context);
                                      },
                                    ),

                                  ]),
                            ),

                          ]),
                          SizedBox(height: 8,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: (widget.product.rating !=null ) ? Text("Đánh giá:  " +
                              widget.product.rating.toString() + " ☆",
                              style:
                              TextStyle(fontSize: 16, color: Colors.white),
                            ): Text(
                              "Chưa có đánh giá",
                              style:
                              TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),

                        ]),
                  ),
          ]),
          )),
          Container(
                    padding: const EdgeInsets.only(top: 30),
                    width: screenWidth * 0.58,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          height: 280,

                          child: new Carousel(
                            boxFit: BoxFit.cover,
                            images: widget.product.listImage.map((item) =>
                            NetworkImage(item.toString())).toList(),
                            autoplay: false,
                            animationCurve: Curves.fastOutSlowIn,
                            animationDuration: Duration(milliseconds: 1000),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ));
  }
  addProductToCart(){

  }
  showAlert(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Image.asset("assets/checkIcon.png", width: 50, height: 50,),
      content: Text("Sản phẩm đã được thêm vào giỏ hàng"),
    );
    showDialog(
      context: context,
      builder: (BuildContext) {
        return alert;
      }
    );
  }


}
