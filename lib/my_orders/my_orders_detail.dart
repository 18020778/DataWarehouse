import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/buy_products/show_cart_0.dart';
import 'package:first_app/login_reg_pages/loading.dart';
import 'package:first_app/models/OrderDetail.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/models/shippingInfor.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/my_orders/product_short.dart';
import 'package:first_app/services/database.dart';
import 'package:first_app/services/deliveryService.dart';
import 'package:first_app/services/productService.dart';
import 'package:first_app/services/purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class MyOrderDetail extends StatefulWidget{
  User user;
  OrderDetail orderDetail;
  @override
  _MyOrderDetailState createState()=> _MyOrderDetailState();

  MyOrderDetail(this.user, this.orderDetail);
}
class _MyOrderDetailState extends State<MyOrderDetail>{
  shippingInfor deliverInfor;
  String nameShop;
  int viewResult = 0;
  Product product;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deliveryService().getDelivery(widget.user.uid, widget.orderDetail.deliverID).then(( QuerySnapshot docs){
      if(docs.documents.isNotEmpty){
        setState(() {
          deliverInfor = shippingInfor.fromJson(docs.documents[0].data);
          viewResult +=1;
        });
      }
    });
    Database().getUser(widget.user.uid).then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty){
        setState(() {
          this.nameShop = docs.documents[0].data['userName'];
          this.viewResult +=1;
        });
      }
    });

    // getProduct
    ProductService().getProductByID(widget.orderDetail.productId).then(( QuerySnapshot value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          product = Product.fromJson(element.data);
          ProductService().getImageProduct(product.productID).then((QuerySnapshot image){
            if(image.documents.isNotEmpty){
              List<String> listImage = new List();
              image.documents.forEach((element) {
                listImage.add(element.data['imageUrl']);
              });
              product.setlistImage(listImage);
            }else
              product.setlistImage(['https://cdn.shopify.com/s/files/1/0212/1030/0480/products/BraidedMoneyTree-Full_560x560_crop_center.jpg?v=1605012647']);
            if(product.listImage.isNotEmpty){
              setState(() {
                this.viewResult +=1;
              });
            }
          });
        });
      }
    });

  }
  @override
  Widget build(BuildContext context){
    return (this.viewResult==3) ? Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF407C5A),
        title: Text(
          "Thông tin đơn hàng",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_location),
                      Text('  Địa chỉ nhận hàng', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    deliverInfor.name, style: TextStyle(fontSize: 18),
                  ),
                  Text(
                       deliverInfor.phoneNumber,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                        deliverInfor.address,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(height: 10,),
            Container(
              height: 40,
              color: Colors.grey[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/shop.png", width: 20, fit: BoxFit.cover,),
                  Text(
                    "   "+nameShop, // shop.username,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 8,
              ),

              child: ProductShort(widget.orderDetail),
            ),
            SizedBox(height: 20,),
            Container(
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:8),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        ' Tổng số tiền: ',
                      style: TextStyle(fontSize: 18, height: 2, fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    Text(
                      widget.orderDetail.productMoney.toString(),
                      style: TextStyle(fontSize: 18, height: 2),
                    )
                  ],
                ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       ' Phí ship: ',
                  //       style: TextStyle(fontSize: 18, height: 2),
                  //     ),
                  //     Spacer(),
                  //     Text(
                  //       ' 15000',
                  //       style: TextStyle(fontSize: 18, height: 2),
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       ' Tổng thanh toán: ',
                  //       style: TextStyle(fontSize: 22, height: 2,fontWeight: FontWeight.bold),
                  //     ),
                  //     Spacer(),
                  //     Text(
                  //       '135000',
                  //       style: TextStyle(fontSize: 22, height: 2),
                  //     )
                  //   ],
                  // ),
          ],
        ),
      ),
           SizedBox(height: 20,),

           Container(
             color: Colors.grey[200],
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 SizedBox(height:8),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       'Mã đơn hàng: ',
                       style: TextStyle(fontSize: 18, height: 2),
                     ),
                     Spacer(),
                     Text(
                       widget.orderDetail.orderDetailID,
                       style: TextStyle(fontSize: 18, height: 2),
                     )
                   ],
                 ),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       'Thời gian đặt hàng: ',
                       style: TextStyle(fontSize: 18, height: 2),
                     ),
                     Spacer(),
                     Text(
                       DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.orderDetail.dateTime.seconds*1000)),
                       style: TextStyle(fontSize: 18, height: 2),
                     )
                   ],
                 ),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       'Thời gian hoàn thành: ',
                       style: TextStyle(fontSize: 18, height: 2,fontWeight: FontWeight.bold),
                     ),
                     Spacer(),
                     Text(
                       DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch((widget.orderDetail.dateTime.seconds + 7200*60)*1000)),
                       style: TextStyle(fontSize: 18, height: 2),
                     )
                   ],
                 ),
               ],
             ),
           ),
           SizedBox(height: 30,),
           ButtonBar(
             alignment: MainAxisAlignment.center,
             buttonMinWidth: 150,
             layoutBehavior: ButtonBarLayoutBehavior.padded,
             buttonPadding: EdgeInsets.symmetric(vertical: 10),
             children: <Widget>[
               FlatButton(
                 child: Text('Mua lại', style: TextStyle(fontSize: 20)),
                 color: Color(0xFF407C5A),
                 onPressed: (){
                   PurchaseService().addProductToTheCart(product.productID, 1, widget.user.uid, product.accountID, product.listImage.last, product.productName, product.price);
                   Navigator.push(context, MaterialPageRoute(builder: (context) => showCart(widget.user)));
                 },
               ),
             ],
           )
    ],
    )
      ),

    ) : Loading();
  }
}

