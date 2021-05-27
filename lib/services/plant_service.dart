import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlantService{
  getPlants()  {
    return   Firestore.instance
        .collection("plants")
        .getDocuments();
  }
  getPlantsGroupByCategory(String categoryId){
    return Firestore.instance
          .collection("plants")
          .where('categoryId', isEqualTo: categoryId)
          .getDocuments();
  }
}