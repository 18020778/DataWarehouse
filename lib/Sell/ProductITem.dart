import 'package:first_app/Sell/product_detail.dart';
import 'package:first_app/models/posted_products.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/likeProduct.dart';
import 'package:first_app/show_products_page/detail_item_4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  Product product;
  User user;
  ProductItem({this.product, this.user});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isFavorited = true;
  @override
  Widget build(BuildContext context) {
    var setImage = this.isFavorited
        ? Image.asset(
      'assets/heart_like.png',
      width: 16,
    )
        : Image.asset(
      'assets/heart.png',
      width: 16,
    );

    return Padding(
      padding: EdgeInsets.only(left: 5, top: 5, right: 10, bottom: 0),
      child: Container(
        child: InkWell(
          onTap: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ProductDetail(postedProducts: new PostedProducts(widget.user, widget.product),))
            );
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(4291751385),
                            offset: Offset(0, 140),
                            spreadRadius: 0,
                            blurRadius: 100.0),
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 2.0,
                            blurRadius: 2.0),
                      ]),
                  margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 136,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child:  Image.network(
                          widget.product.listImage.last,
                          width: 200,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.product.plantID,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.product.price + 'đ',
                                      style: TextStyle(color: Colors.green[900]),
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            style: TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Đã bán ',
                                              ),
                                              TextSpan(text: widget.product.sold.toString()),
                                            ]))
                                  ],
                                ),
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/gold_star.png",
                                            width: 16,
                                          ),
                                          (widget.product.rating!=0) ? Text(" " + widget.product.rating.toString(), style: TextStyle(
                                            fontSize: 12,
                                          ),) : Text(" null" , style: TextStyle(
                                            fontSize: 12,
                                          ),),
                                        ],
                                      ) ,
                                      //isFavorited là biến bool, xét xem ng đó đã tym sp đó chưa
                                      Row(
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/location_small.png",
                                            width: 16,
                                          ),
                                          Text(" " + widget.product.address, style: TextStyle(
                                            fontSize: 12,
                                          ),),
                                        ],
                                      )
                                    ])
                              ]))
                    ],
                  ))
            ],

          ),
        ),
      ),
    );
  }
}
