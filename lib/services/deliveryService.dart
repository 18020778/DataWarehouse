import 'package:cloud_firestore/cloud_firestore.dart';

class deliveryService{
  Firestore _firestore  = new Firestore();
  getDelivery(String uid, String deliveryID){
    return _firestore.collection("users").document(uid)
        .collection("delivers").where('uid', isEqualTo: deliveryID).getDocuments();
  }
}