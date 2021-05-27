import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/login_reg_pages/loading.dart';
import 'package:first_app/models/plant.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/plant_service.dart';
import 'package:first_app/services/productService.dart';
import 'package:first_app/show_products_page/SuggestionItem.dart';
import 'package:first_app/show_products_page/group_of_trees_0.dart';
import 'package:first_app/show_products_page/search_box_012.dart';
import 'package:first_app/show_products_page/show_items_3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'TreeItem.dart';

class TypeOfTrees extends StatefulWidget {
  User user;
  String categoryId;
  @override
  _TypeOfTreesState createState() => _TypeOfTreesState();
  TypeOfTrees(this.categoryId, this.user);
}

class _TypeOfTreesState extends State<TypeOfTrees> {


  var  viewResult = 0;
  List<Plants> listPlantGroupByCategory = new List();
  List<Product> listProduct = new List();
  PageController controller =
      PageController(viewportFraction: 0.4, initialPage: 1);

  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return (this.viewResult == 2) ? Scaffold(
      appBar: AppBar(
          toolbarHeight: 75,
          //title: SearchBox(text: 'NameTypeOfTree'),
          leadingWidth: 20,
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
            )
          ]),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "Nhóm cây",
              style: TextStyle(
                  color: Color(4281755650),
                  fontWeight: FontWeight.w700,
                  fontSize: 25),
            ),
          ),
          ListGroupOfTrees(this.listPlantGroupByCategory, widget.user),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "Top sản phẩm bán chạy",
              style: TextStyle(
                  color: Color(4281755650),
                  fontWeight: FontWeight.w700,
                  fontSize: 25),
            ),
          ),
         SuggestionItem(listProduct, widget.user),
        ],
      )),
      //bottomNavigationBar: BottomNavBar(),
    ) : Loading();
  }

  @override
  void initState() {
    PlantService().getPlantsGroupByCategory(widget.categoryId).then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty){
          docs.documents.forEach((element) {
              listPlantGroupByCategory.add(Plants.fromJson(element.data));
          });
      }
      setState(() {
        this.viewResult += 1;
      });
    });

    // top 10 san pham ban chay cua cai nhom cay nay nhes
    int count ;
    List<Product> newList = new List();
    ProductService().top10ProductOrderByCategory(widget.categoryId).then((QuerySnapshot docs){
      count = docs.documents.length;
      if(count == 0){
        setState(() {
          this.viewResult+=1;
        });
      }
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
            newList.add(product);
            if(newList.length == count){
              this.setState(() {
                this.listProduct = newList;
                this.viewResult+=1;
              });
            }
          });
        });
      }
    });

  }
}
