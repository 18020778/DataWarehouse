import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/user.dart';

class handBook{
  String handbookId;
  String title ;
  String plantName;
  String content ;
  String imageUrl;
  Timestamp timeCreated;
  String userUid;
  // String userName;
  // String avatarArticle;

  //
  // void setUserName(String userName){
  //   this.userName = userName;
  // }
  //
  // void setAvatarArticle(String avatarArticle){
  //   this.avatarArticle = avatarArticle;
  // }

  void setUserUid(String userUid){
    this.userUid = userUid;
  }

  void setHandBookId(String id){
    this.handbookId = id;
  }



  void setTitle(String title){
    this.title = title;
  }

  void setPlantName(String plantName){
    this.plantName = plantName;
  }

  void setContent(String content){
    this.content = content;
  }

  void setImageUrl(String imageUrl){
    this.imageUrl = imageUrl;
  }

  void setTimeCreated(Timestamp timestamp){
    this.timeCreated = timestamp;
  }
  handBook({
    this.handbookId,
    this.title,
    this.plantName,
    this.content,
    this.imageUrl,
    this.timeCreated,
    this.userUid,
});
  factory handBook.fromJson(Map<String, dynamic> json) => handBook(
    handbookId: json['handbookId'],
    title: json['title'],
    plantName: json['plantName'],
    content: json['content'],
    imageUrl: json['imageUrl'],
    timeCreated: json['timeCreated'],
    userUid: json['userUid'],
  );
   handBook.fromMap(json)  :
    handbookId= json['handbookId'].toString(),
    title =  json['title'].toString(),
    plantName= json['plantName'].toString(),
    content= json['content'].toString(),
    imageUrl= json['imageUrl'].toString(),
    timeCreated= json['timeCreated'],
    userUid= json['userUid'].toString();

}