
import 'package:first_app/models/OrderDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductShort extends StatelessWidget {
  OrderDetail orderDetail;
  ProductShort(this.orderDetail);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
          child: Row(
              children: [
                Image.network(
                  orderDetail.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Padding(
                    padding:  EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderDetail.productName,
                          style: TextStyle(fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderDetail.price,//Giá tiền
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 100,),
                            Text(
                              'x'+ orderDetail.amount.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Thành tiền',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 80,),
                            Text(
                              orderDetail.productMoney.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                )
              ],
          ),
    );

  }

}

