import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/login_reg_pages/loading.dart';
import 'package:first_app/models/articles.dart';
import 'package:first_app/models/handBook.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/database.dart';
import 'package:first_app/services/handbookService.dart';
import 'package:first_app/services/likeArticles_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'create_blog.dart';
import 'detail_blog.dart';

class SummaryNews extends StatefulWidget {
  User user;
  SummaryNews({this.user});
  @override
  _SummaryNewsState createState() => _SummaryNewsState();
}

class _SummaryNewsState extends State<SummaryNews> {
  List<Articles> articles= new List();
  var count;
  loadingData() async {
    List<Articles> rawData = new List();
    await handbookService().getAllHandBook().then((QuerySnapshot value){
      count = value.documents.length;
      if(value.documents.isNotEmpty) {
        value.documents.forEach((element){
          Database().getUserInfo(element.data['userUid']).then((value){
            rawData.add(new Articles(value, handBook.fromJson(element.data)));
            if(rawData.length == count)
            {
              setState(() {
                this.articles = rawData;
              });
            }
          });
        });
      }
    });
    return this.articles;
  }

  @override
  Widget build(BuildContext context) {
    return   Container(
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
            title: Text('Cẩm nang chăm cây', style: TextStyle(fontSize: 28),),
            automaticallyImplyLeading: false,

            // actions: <Widget>[
            //   IconButton(icon: Icon(Icons.search, size: 28,), onPressed: (){
            //
            //   })
            // ],
            // bottom: TabBar(
            //   isScrollable: true,
            //   indicatorColor: Colors.white,
            //   tabs: <Widget>[
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text("Hoa hồng", style: TextStyle(fontSize: 18)),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text("Hoa cúc", style: TextStyle(fontSize: 18)),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text("Hoa lan", style: TextStyle(fontSize: 18)),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text("Bonsai", style: TextStyle(fontSize: 18)),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text('Cây ăn quả', style: TextStyle(fontSize: 18),),
            //     ),
            //   ],
            // ),
          ),
          body: FutureBuilder(
            future: loadingData(),
            builder: (context,  AsyncSnapshot snapshot){
              if(snapshot.hasData){
                return Container(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                      itemCount:this.articles.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context,index) {
                        return _buildArticleItem(this.articles, index);
                      },
                      // separatorBuilder: (context, index) => SizedBox(height: 16)
                    ));
                // child: TabBarView(
                //   children: <Widget>[
                //     ListView.separated(
                //       ,),
                //   ],
                //),
              }else
                return Loading();
            },
          ),


          /*body: Container(
                        color: Colors.blueGrey[50],
                        child: TabBarView(
                          children: <Widget>[
                            ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                              itemCount: 5,
                              itemBuilder: (context,index) {
                                //return _buildArticleItem(snapshot.data, index);
                              },
                              separatorBuilder: (context, index) => SizedBox(height: 16),),
                          ],
                        ),
                      ),*/
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Color(0xFF407C5A),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBlog(user: widget.user,)));
                },
                child: Icon(FontAwesomeIcons.pen),)
            ],
          ),
        ),
      ),
    );
    //       }
    //       else return Loading();
    // });

  }
  Widget _buildArticleItem(List articles,int index) {
    Articles article = articles[index];
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailBlog(articles: article,)));
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
                        child: Image.network(article.handbook.imageUrl, fit: BoxFit.cover,),
                      ),
                      SizedBox(width: 20,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 65,
                            child: Text(article.handbook.title,
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
                                      backgroundImage: NetworkImage(article.author.getUrlImage())
                                  )),
                                  WidgetSpan(child: SizedBox(width: 5,)),
                                  TextSpan(
                                    text: article.author.getUserName(),
                                    style: TextStyle(fontSize: 17),
                                  ) ,
                                  WidgetSpan(child: SizedBox(width: 25,)),
                                  //WidgetSpan(child: SizedBox(width: 5,)),
                                  TextSpan(
                                    text: DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(article.handbook.timeCreated.seconds*1000)), style: TextStyle(fontSize: 17),
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