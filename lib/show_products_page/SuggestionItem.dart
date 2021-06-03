import 'package:first_app/models/product.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/productService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail_item_4.dart';

class SuggestionItem extends StatelessWidget {
  List<Product> listProduct = new List();
  User user;

  SuggestionItem(this.listProduct, this.user);

  @override
  Widget build(BuildContext context) {
    PageController controller =
    PageController(viewportFraction: 0.6, initialPage: 1);
    List<Widget> banners = new List<Widget>();
    for (int i = 0; i < listProduct.length; i++) {
      var bannerView = Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
        child: InkWell(
          onTap: () {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailItem(product: listProduct[i], user: user,)));
            ProductService().updateWatched(listProduct[i].productID, listProduct[i].watched);
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
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
                          listProduct[i].listImage.last,
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
                                  listProduct[i].plantID,
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
                                      listProduct[i].price +'đ',
                                      style: TextStyle(color: Colors.green[900]),
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            style: TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Đã bán ',
                                              ),
                                              TextSpan(text: listProduct[i].sold.toString()),
                                            ]))
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      //isFavorited là biến bool, xét xem ng đó đã tym sp đó chưa

                                      Row(
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/gold_star.png",
                                            width: 16,
                                          ),
                                          (listProduct[i].rating!=0) ? Text(" " + listProduct[i].rating.toString(), style: TextStyle(
                                            fontSize: 12,
                                          ),) : Text(" null" , style: TextStyle(
                                            fontSize: 12,
                                          ),),
                                        ],
                                      ) ,
                                      Row(
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/location_small.png",
                                            width: 16,
                                          ),
                                          Text(" " + listProduct[i].address, style: TextStyle(
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
        );
      banners.add(bannerView);
    }
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.95,
        height: MediaQuery
            .of(context)
            .size
            .width *0.7,
        child: PageView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          children: banners,

        ));
  }
}