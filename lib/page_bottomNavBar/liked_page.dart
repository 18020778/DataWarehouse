import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/login_reg_pages/loading.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/likeProduct.dart';
import 'package:first_app/services/productService.dart';
import 'package:first_app/show_products_page/TreeItem.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LikedPage extends StatefulWidget {
  User user;
  @override
  _LikedPageState createState() => _LikedPageState();
  LikedPage({this.user});
}

class _LikedPageState extends State<LikedPage> {
  List<String> _options = ["Tất cả", "Gần đây"];
  int _selectedIndex = 0;
  List<Product> listProduct= new List();

  loadingData()async{
    // lấy tất cả sản phẩm

    // int count ;
    // List<Product> newList = new List();
    // ProductService().getAllProduct().then((QuerySnapshot docs){
    //   count = docs.documents.length;
    //   if(docs.documents.isNotEmpty){
    //     docs.documents.forEach((element) {
    //       Product product = Product.fromJson(element.data);
    //       ProductService().getImageProduct(element.data['productID']).then(( QuerySnapshot value){
    //         if(value.documents.isNotEmpty){
    //           List<String> listImage = new List();
    //           value.documents.forEach((element) {
    //             listImage.add(element.data['imageUrl']);
    //           });
    //           product.setlistImage(listImage);
    //         }
    //         else{
    //           product.setlistImage(['https://img.freepik.com/free-vector/tree_1308-36471.jpg?size=626&ext=jpg']);
    //         }
    //         newList.add(product);
    //         if(newList.length == count){
    //           this.setState(() {
    //             this.listProduct = newList;
    //
    //           });
    //         }
    //       });
    //     });
    //   }
    // });
    //
    // return this.listProduct;

    // lấy tất cả sản phẩm đã like .
      int count;
      List<Product> newList = new List();
    likeProduct().getLikedProduct(widget.user.getUid()).then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty){
         count = docs.documents.length;
        docs.documents.forEach((element) {
          ProductService().getProductByID(element.data['productID']).then(( QuerySnapshot value){
            if(value.documents.isNotEmpty){
              value.documents.forEach((element) {
                Product product = Product.fromJson(element.data);
                ProductService().getImageProduct(product.productID).then((QuerySnapshot image){
                  if(image.documents.isNotEmpty){
                    List<String> listImage = new List();
                    image.documents.forEach((element) {
                      listImage.add(element.data['imageUrl']);
                    });
                    product.setlistImage(listImage);


                  }else product.setlistImage(['https://cdn.shopify.com/s/files/1/0212/1030/0480/products/BraidedMoneyTree-Full_560x560_crop_center.jpg?v=1605012647']);
                  newList.add(product);
                  if(newList.length == count){
                    setState(() {
                      this.listProduct = newList;
                    });
                  }
                });


              });
            }
          });
        });

      }
    });
    return this.listProduct;
  }

  Widget _buildMenu(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width*0.49,
        decoration: BoxDecoration(
          color: Color(4291751385),
        ),
        child: FlatButton(
          onPressed: () {},
          //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: Text(
            _options[index],
            style: TextStyle(
              color: _selectedIndex == index ? Colors.black : Color(0xFF407C5A),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Text("Lượt thích", style: TextStyle(fontSize: 23),),
           // leadingWidth: 20,
            centerTitle: true,
            backgroundColor: Color(0xFF407C5A),
            actions: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.bell,
                  color: Colors.white,
                  size: 27.0,
                ),
                onPressed: () {},
              ),
            ]),
        body: FutureBuilder(
          future: loadingData(),
            builder: (context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height: 600,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: _options
                                    .asMap()
                                    .entries
                                    .map(
                                      (MapEntry map) => _buildMenu(map.key),
                                )
                                    .toList(),
                              ),
                              Expanded(
                                child: GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                  childAspectRatio: 0.7),

                                      itemCount: this.listProduct.length,
                                      itemBuilder: (context, index){

                                    return TreeItem(
                                       product: this.listProduct[index],
                                        user: widget.user,
                                    );
                                      }
                                ),

                              ),

                            ],
                          )),
                    ],
                  )
              );
            }else{
              return Loading();
            }
        })

    );
  }
}
