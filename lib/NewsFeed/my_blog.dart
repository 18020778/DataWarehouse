import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/login_reg_pages/loading.dart';
import 'package:first_app/models/articles.dart';
import 'package:first_app/models/handBook.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/database.dart';
import 'package:first_app/services/handbookService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'create_blog.dart';
import 'detail_blog.dart';

class MyBlog extends StatefulWidget {
  User user;
  @override
  _MyBlogState createState() => _MyBlogState();
  MyBlog({this.user});
}

class _MyBlogState extends State<MyBlog> {
  List<handBook> blog = new List();
  bool viewResult  =  false;

  @override
  void initState() {
    handbookService().getHandBook(widget.user.getUid()).then((QuerySnapshot value){
      if (value.documents.isNotEmpty){
        value.documents.forEach((element) {
          blog.add(handBook.fromJson(element.data));
        });
        setState(() {
          this.viewResult = true;
        });
      }else{
        setState(() {
          this.viewResult = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.viewResult ? DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Theme(
        data: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: Color(0xFF407C5A),
                actionsIconTheme: IconThemeData(color: Colors.white)
            )
        ),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            centerTitle: true,
            title: Text('Bài viết của tôi', style: TextStyle(fontSize: 28),),
            automaticallyImplyLeading: false,
          ),
          body: Container(
            color: Colors.blueGrey[50],
            child: TabBarView(
              children: <Widget>[
                ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                  itemCount: blog.length,
                  itemBuilder: (context,index) {
                    return _buildArticleItem(blog, index);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16),),

                ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                  itemCount: blog.length,
                  itemBuilder: (context,index) {
                    return _buildArticleItem(blog, index);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16),),
                Container(
                  child: Text("Tab2"),
                ),
                Container(
                  child: Text("Tab3"),
                ),
                Container(
                  child: Text("Tab4"),
                ),
              ],
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Color(0xFF407C5A),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBlog(user: widget.user,))).then((value){
                    if(value!=null)
                    setState(() {
                      this.blog.add(value.handbook);
                    });
                  });
                },
                child: Icon(FontAwesomeIcons.pen),)
            ],
          ),
        ),
      ),
    ) : Loading();
  }
  Widget _buildArticleItem(List articles,int index) {
    handBook article = articles[index];
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

                Articles detail = new Articles(widget.user, article);
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailBlog(articles: detail,)));
              },
              child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(0, 12,10, 10),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        color: Colors.blue,
                        width: 80,
                        child: Image.network(article.imageUrl, fit: BoxFit.cover,),
                      ),
                      SizedBox(width: 20,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 65,
                            child: Text(article.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                textAlign: TextAlign.justify,
                                style: TextStyle(color: Color(0xff324558), fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                          Text.rich(
                            TextSpan(
                                children: [
                                  WidgetSpan(child: CircleAvatar(
                                      radius: 15,
                                      backgroundImage: NetworkImage(widget.user.getUrlImage())
                                    // backgroundImage: NetworkImage(article.user.getUrlImage())
                                  )),
                                  WidgetSpan(child: SizedBox(width: 5,)),
                                  TextSpan(
                                    text: widget.user.getUserName(),
                                    style: TextStyle(fontSize: 17),
                                  ) ,
                                  WidgetSpan(child: SizedBox(width: 25,)),
                                  //WidgetSpan(child: SizedBox(width: 5,)),
                                  TextSpan(
                                    text: DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(article.timeCreated.seconds*1000)), style: TextStyle(fontSize: 17),
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
