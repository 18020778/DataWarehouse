import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/services/productService.dart';

class likeProduct{
  Firestore _firestore = new Firestore();

  getLikedProduct(String accountID){
    return _firestore.collection("users").document(accountID).collection("productLiked").getDocuments();
        
  }

  Future<bool> isLiked(String accountID, String productID ) async{
    DocumentSnapshot docs = await _firestore.collection("users").document(accountID).collection("productLiked").document(productID).get();
    if(docs.exists){
      return true;
    }
    else{
      return false;
    }
  }


  Future<void> addFavoriteProduct(String accountID, String productID) async{
    String retVal = "error";
    try{
      await _firestore.collection("users").document(accountID).collection("productLiked").document(productID)
          .setData(
          {
            'productID': productID,
          });
      ProductService().updateLike(productID, true);
      retVal = "success";
    }catch(e){

    }
    return retVal;
  }
  Future<void> deleteFavoriteProduct(String accountID, String productID) async{
    String retVal = "error";
    try{
      await _firestore.collection("users").document(accountID).collection("productLiked")
          .document(productID).delete();
      ProductService().updateLike(productID, false);
      retVal = "success";
    }catch(e){
    }
    return retVal;
  }
}