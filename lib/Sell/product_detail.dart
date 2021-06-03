import 'package:first_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/posted_products.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:like_button/like_button.dart';

class ProductDetail extends StatefulWidget{
  User user;
  PostedProducts postedProducts;
  @override
  _ProductDetailState createState() =>  _ProductDetailState();
  ProductDetail({this.postedProducts, this.user});
}
class  _ProductDetailState extends State<ProductDetail>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF407C5A),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            'Sản phẩm của tôi',
            style:TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body:SingleChildScrollView(
          child: Column(
            children:<Widget> [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              height: 250,
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 250,
                    child: new Carousel(
                      boxFit: BoxFit.cover,
                      images: widget.postedProducts.product.listImage.map((item) =>
                          NetworkImage(item.toString())).toList(),
                      dotColor: Color(0xFF407C5A),
                      autoplay: false,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(milliseconds: 1000),
                    ),
                  )

                ],

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.postedProducts.product.productName,
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height:16.0),
                  Row(
                    children: [
                      Icon(Icons.favorite, size: 20, color: Colors.red,),
                      Text('  Thích  ', style: TextStyle(fontSize: 18),),
                      Text(widget.postedProducts.product.liked.toString(), style: TextStyle(fontSize: 18),),
                      SizedBox(width: 80,),
                      Icon(Icons.preview_outlined, size:20,),
                      Text(' Lượt xem  ',style: TextStyle(fontSize: 18),),
                      Text(widget.postedProducts.product.watched.toString(), style: TextStyle(fontSize: 18),),
                    ],
                  ),
                  const SizedBox(height:16.0),
                  Row(
                    children: [
                      Icon(Icons.account_balance_rounded, size: 20, ),
                      Text('  Số lượng  ', style: TextStyle(fontSize: 18),),
                      Text(
                        widget.postedProducts.product.quantityInStock,
                        style: TextStyle(fontSize: 18),),
                      SizedBox(width:42,),
                      Icon(Icons.monetization_on, size:20, ),
                      Text(' Đã bán  ',style: TextStyle(fontSize: 18),),
                      Text(widget.postedProducts.product.sold.toString(), style: TextStyle(fontSize: 18),),
                    ],
                  ),

                  const SizedBox(height: 16.0),
                  Text(
                    'Cách chăm sóc:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    widget.postedProducts.product.takeCareOfTree,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18,),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Đặc tả cây:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Icon(Icons.alarm, size: 20,),
                      Text(' Tuổi thọ (tháng): ', style: TextStyle(fontSize: 18),),
                      Text(
                        widget.postedProducts.product.longevity,
                        //widget.postedProducts.product.longevity,
                        style: TextStyle(fontSize: 18),),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                    Icon(Icons.account_balance, size:20,),
                    Text(' Xuất xứ: ',style: TextStyle(fontSize: 18),),
                    Text(
                      widget.postedProducts.product.origin,
                    // widget.postedProducts.product.address,
                      style: TextStyle(fontSize: 18),),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Icon(Icons.add_location, size: 20, color: Colors.blue,),
                      Text(' Lượng nước: ', style: TextStyle(fontSize: 18),),
                      Text(
                        widget.postedProducts.product.theAmountOfWater,
                        style: TextStyle(fontSize: 18),),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Icon(Icons.add_circle_sharp, size: 20,),
                      Text('  Nhiệt độ: ', style: TextStyle(fontSize: 18),),
                      Text(
                        widget.postedProducts.product.temperature,
                        style: TextStyle(fontSize: 18),),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [

                      Icon(Icons.add_circle_sharp, size:20,),
                      Text(
                        ' Chiều cao(m): ',
                        style: TextStyle(fontSize: 18),),
                      Text(
                        widget.postedProducts.product.height,
                        style: TextStyle(fontSize: 18),),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children:[
                   Text(
                    'Phân loại cây: ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                   ),
                   const SizedBox(width: 40.0),
                   Text(
                      widget.postedProducts.product.category,
                    style: TextStyle(fontSize: 18,),
                  ),]),

                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}