
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_sorted_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/handbookService.dart';
import 'package:first_app/services/productService.dart';
import 'package:flutter/cupertino.dart';


class uploadFile {
  Future uploadImageToFirebase(String uid, File _imageFile) async {
    StorageReference reference = FirebaseStorage.instance.ref().child(
        "users/$uid/avatar");
    StorageUploadTask uploadTask = reference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadImage = await taskSnapshot.ref.getDownloadURL();
    Firestore.instance.collection("users").document(uid).updateData({
      'urlImage' : downloadImage
    });
    return taskSnapshot.ref.getDownloadURL();
  }
  Future uploadImageHandBook(String userUid,String handbookUid, File _imageFile) async{
    // dau tien la phai lay cai so luong r la chia no ra
    var number = 0;
    await handbookService().getHandBook(userUid).then((QuerySnapshot value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          print(number);
          number++;
        });
      }
    });
    // up file to storage in firebase
      StorageReference reference = FirebaseStorage.instance.ref().child(
          "handbooks/$userUid/image_$number");
      StorageUploadTask uploadTask = reference.putFile(_imageFile);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String downloadImage = await taskSnapshot.ref.getDownloadURL();
      Firestore.instance.collection("handbooks").document(handbookUid).updateData({
        'imageUrl' : downloadImage
      });
      return taskSnapshot.ref.getDownloadURL();
  }


  Future<String> uploadImageProduct(String productID, File _imageFile, int index) async {
    var number = 0;
    StorageReference reference = FirebaseStorage.instance.ref().child(
        "productImage/$productID/image_$index"
    );
    StorageUploadTask uploadTask = reference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadImage = await taskSnapshot.ref.getDownloadURL();
    CollectionReference ref = Firestore.instance.collection("products").document(productID).collection("imageProduct");
    DocumentReference document = ref.document();
    document.setData({
      'imageUrl': downloadImage,
      'productID': productID
    });
    return downloadImage;
  }
}