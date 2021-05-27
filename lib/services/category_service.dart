import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/models/categories.dart';

class CategoryService{
   getCategories()  {
    return   Firestore.instance
        .collection("categories")
        .getDocuments();
  }
}