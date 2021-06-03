  import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/login_reg_pages/loading.dart';
import 'package:first_app/models/articles.dart';
import 'package:first_app/services/likeArticles_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailBlog extends StatefulWidget {
  Articles articles;
  @override
  _DetailBlogState createState() => _DetailBlogState();
  DetailBlog({this.articles});
}

class _DetailBlogState extends State<DetailBlog> {
  bool isFavorited = false;
  bool  viewResult = false;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    likeArticlesService().isLiked(widget.articles.handbook.handbookId,widget.articles.author.getUid()).then((value){
      if(value!=null)
        setState(() {
          this.isFavorited = value;
          this.viewResult = true;
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
    return (this.viewResult) ? Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          height: 250,
          width: screenWidth,
          child: Stack(children: [
            ListView(
              children: <Widget>[
                Container(
                  height: 250,
                  child: new Carousel(
                    boxFit: BoxFit.cover,
                    images: [
                      NetworkImage(widget.articles.handbook.imageUrl)
                    ],
                    dotColor: Color(0xFF407C5A),
                    autoplay: false,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 1000),
                  ),
                )
              ],
            ),
            Positioned(
                top: 10,
                left: 5,
                child: IconButton(
                    onPressed: () => Navigator.pop(context, false),
                    icon: Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: Color(0xFF407C5A),
                    ))),
            Positioned(
                top: 200,
                left: 20,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.articles.author.getUrlImage()),
                      radius: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.articles.author.getUserName().toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    )
                  ],
                )),
          ])),
      SizedBox(
        height: 15,
      ),
      Expanded(
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: screenWidth * 0.75,
                          child: Text(
                              widget.articles.handbook.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color: Color(0xFF407C5A),
                              )),
                        ),
                        Spacer(),
                        IconButton(
                            icon: (setImage),
                            onPressed: () {
                              setState(() {
                                this.isFavorited = !this.isFavorited;
                              });
                              if(this.isFavorited){
                                likeArticlesService().likeArticle(widget.articles.handbook.handbookId, widget.articles.author.getUid());
                              }else{
                                likeArticlesService().deleteLikeArticle(widget.articles.handbook.handbookId, widget.articles.author.getUid());
                              }
                            }),
                      ]),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.articles.handbook.timeCreated.seconds*1000)),
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                      widget.articles.handbook.content,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 18),
                      ),
                    ]))),
      )
    ])) : Loading();
  }
}
