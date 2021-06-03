import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:first_app/models/shippingInfor.dart';
class User{
  String uid;
  String userName;
  String phoneNumber;
  String email;
  String urlImage;
  String gender;
  Timestamp accountCreated;
  Timestamp dob;
  List<shippingInfor> listShippingInfor;

  // getter and setter
  addListShippingInfor(shippingInfor addInfor){
    this.listShippingInfor.add(addInfor);
  }
  Timestamp getAccountCreated(){
    return this.accountCreated;
  }
  Timestamp getDob(){
    return this.dob;
  }
  void setDob(Timestamp timestamp){
    this.dob = timestamp;
  }
  String getUid(){
    return this.uid;
  }
  void setUid(String uid){
    this.uid = uid;
  }
  String getUserName(){
    return this.userName;
  }
  void setUserName(String userName){
    this.userName = userName;
  }
  String getPhoneNumber(){
    return this.phoneNumber;
  }
  void setPhoneNumber(String phoneNumber){
    this.phoneNumber = phoneNumber;
  }

  String getEmail(){
    return this.email;
  }
  void setEmail(String email){
    this.email = email;
  }
  String getUrlImage(){
    return this.urlImage;
  }
  void setUrlImage(String urlImage){
    this.urlImage = urlImage;
  }
  String getGender(){
    return this.gender;
  }
  void setGender(String gender){
    this.gender = gender;
  }

}