import 'package:first_app/models/OrderDetail.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/productService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class ReviewDialog extends StatelessWidget{
  OrderDetail orderDetail;
  User user;
  String feedback  = "";
  double rating = 0;

  ReviewDialog(this.orderDetail, this.user);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Center(
        child: Text(
          'Review',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      children: [
        Center(
          child: RatingBar.builder(
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context,_)=>Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating){
             this.rating = rating;
            },
          ),
        ),
        SizedBox(height: 20,),
        Center(
          child: TextFormField(
            decoration:  InputDecoration(
              hintText: "Feedback to Shop",
              hintStyle: TextStyle(fontSize: 16),
              labelText: "Feedback",
              labelStyle: TextStyle( fontSize: 28, color: Colors.black,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.black, width: 5),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            maxLines: null,
            maxLength: 150,
            onChanged: (value){
              this.feedback = value;
            },
          ),
        ),
        SizedBox(height: 10,),
        Center(
          child: FlatButton(
            color: Colors.lightGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: (){
              ProductService().addFeedBack(orderDetail.productId, user.uid, rating, feedback);
              Navigator.of(context).pop();
            },
            child: Text(
              'Submit',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}