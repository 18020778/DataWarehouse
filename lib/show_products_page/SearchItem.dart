import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/login_reg_pages/loading.dart';
import 'package:first_app/services/productService.dart';
import 'package:first_app/show_products_page/SuggestionItem.dart';
import 'package:first_app/show_products_page/search_box_012.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/models/user.dart';
import 'package:intl/intl.dart';

import 'TreeItem.dart';



class SearchItem extends  StatefulWidget{
  String queryString;
  User user;
  @override
  State<StatefulWidget> createState()  =>  _SearchState();

  SearchItem({this.queryString, this.user});
}
class _SearchState extends State<SearchItem>{
  bool viewResult = false;
  List<Product> myProducts;

  loadingData() async{
    List<Product> products = new List();
    int countCat = 0;
    int countPlant = 0;
    ProductService().getAllProductMatchesCategory(widget.queryString).then((QuerySnapshot docs) {
      countCat = docs.documents.length;
      if (docs.documents.isNotEmpty) {
        docs.documents.forEach((element) {
          Product product = Product.fromJson(element.data);
          ProductService().getImageProduct(element.data['productID']).then(( QuerySnapshot value){
            if(value.documents.isNotEmpty){
              List<String> listImage = new List();
              value.documents.forEach((element) {
                listImage.add(element.data['imageUrl']);
              });
              product.setlistImage(listImage);
            }
            else{
              product.setlistImage(['https://cdn.shopify.com/s/files/1/0212/1030/0480/products/BraidedMoneyTree-Full_560x560_crop_center.jpg?v=1605012647']);
            }
            products.add(product);
            if(products.length == countCat){
              setState(() {
                this.myProducts = products;
              });
            }
          });
        });
      } else {
        ProductService().getAllProductMatchesPlantName(widget.queryString).then((QuerySnapshot docs){
          countPlant= docs.documents.length;
          if(docs.documents.isNotEmpty){
            docs.documents.forEach((element) {
              Product product = Product.fromJson(element.data);
              ProductService().getImageProduct(element.data['productID']).then(( QuerySnapshot value){
                if(value.documents.isNotEmpty){
                  List<String> listImage = new List();
                  value.documents.forEach((element) {
                    listImage.add(element.data['imageUrl']);
                  });
                  product.setlistImage(listImage);
                }
                else{
                  product.setlistImage(['https://cdn.shopify.com/s/files/1/0212/1030/0480/products/BraidedMoneyTree-Full_560x560_crop_center.jpg?v=1605012647']);
                }
                products.add(product);
                if(products.length == countPlant){
                  setState(() {
                    this.myProducts = products;
                  });
                }
              });
            });
          }
          else{
            setState(() {
              this.myProducts = products;
            });
          }
        });
      }
    });
    return this.myProducts;
  }
  // hieenr thij keets quar search
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Theme(
        data: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: Color(0xFF407C5A),
                actionsIconTheme: IconThemeData(color: Colors.white)
            )
        ),
        child:
            Stack(
              children: [

                Container(
                  child:Scaffold(
                    appBar: AppBar(
                      toolbarHeight: 100,
                      centerTitle: true,
                      title: Text('Search', style: TextStyle(fontSize: 28),),
                      automaticallyImplyLeading: false,
                    ),

                    body: FutureBuilder(
                        future: loadingData(),
                        builder: (context,  AsyncSnapshot snapshot){
                          if(snapshot.hasData){
                            return (this.myProducts.length>0) ? Container(
                                height: 600,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 10,),
                                    Expanded(
                                      child: GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.7),
                                          itemCount: this.myProducts.length,
                                          itemBuilder: (context, index){

                                            return TreeItem(
                                              product: this.myProducts[index],
                                              user: widget.user,);
                                          }
                                      ),

                                    ),

                                  ],
                                )
                            ) : Image.asset("assets/NoResult.png",
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,);
                          }else{
                            return Loading();
                          }}
                    ),),
                ),
                // Positioned(
                //   top: 25,
                //   child: Container(
                //     height: 350,
                //     width: MediaQuery.of(context).size.width * 0.9,
                //     margin: EdgeInsets.only(left: 22),
                //     child: SearchBox(widget.user, widget.queryString.toString()),
                //   ),
                // ),
              ],
            )


      ),
    );
  }

  Widget _buildArticleItem(List products, int index) {
    Product product = products[index];
    return Container(
      color: Colors.white,
      child: Stack(
          children: [
            Container(
              width: 90,
              height: 90,
              color: Color(4291751385),
            ),
            FlatButton(
              onPressed: () {

              },
              child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(0, 12, 10, 10),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        color: Colors.blue,
                        width: 80,
                        child: Image.network(
                          product.listImage.last, fit: BoxFit.cover,),
                      ),
                      SizedBox(width: 20,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 65,
                            child: Text(product.productName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                textAlign: TextAlign.justify,
                                style: TextStyle(color: Color(0xff324558),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                          Text.rich(
                            TextSpan(
                                children: [
                                  WidgetSpan(child: CircleAvatar(
                                      radius: 15,
                                      backgroundImage: NetworkImage(
                                          widget.user.getUrlImage())
                                    // backgroundImage: NetworkImage(article.user.getUrlImage())
                                  )),
                                  WidgetSpan(child: SizedBox(width: 5,)),
                                  TextSpan(
                                    text: widget.user.getUserName(),
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  WidgetSpan(child: SizedBox(width: 25,)),
                                  //WidgetSpan(child: SizedBox(width: 5,)),
                                  TextSpan(
                                    text: DateFormat('dd/MM/yyyy').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            product.created.seconds *
                                                1000)),
                                    style: TextStyle(fontSize: 17),
                                  )
                                ]
                            ),
                            style: TextStyle(height: 2),)
                        ],
                      ))
                    ],
                  )),
            )
          ]),
    );
  }
}
