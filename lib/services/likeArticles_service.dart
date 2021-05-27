import 'package:cloud_firestore/cloud_firestore.dart';

class likeArticlesService{
  Firestore _firestore = new Firestore();
  Future<bool> isLiked(String handbookId, String userId ) async{
    DocumentSnapshot docs = await _firestore.collection("handbooks").document(handbookId).collection("accountLiked").document(userId).get();
    if(docs.exists){
      return true;
    }
    else{
      return false;
    }
  }
  Future<void> likeArticle(String handbookId, String userId) async{
    String retVal = "error";
    try{
      await _firestore.collection("handbooks").document(handbookId).collection("accountLiked").document(userId)
          .setData(
          {
            'userId': userId,
          });
      retVal = "success";
    }catch(e){

    }
    return retVal;
  }
  Future<void> deleteLikeArticle(String handbookId, String userId) async{
    String retVal = "error";
    try{
      await _firestore.collection("handbooks").document(handbookId).collection("accountLiked")
          .document(userId).delete();
      retVal = "success";
    }catch(e){
    }
    return retVal;
  }
}