import 'dart:core';
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String productID;
  String productName;
  String takeCareOfTree;
  String longevity;
  String origin;
  String temperature;
  String theAmountOfWater;
  String price;
  String height;
  String plantID;
  String weight;
  bool fastDelivery;
  String quantityInStock;
  bool preOrder;
  String address;
  String accountID;
  Timestamp created;
  String category;
  List<String> listImage;
  int liked;
  int watched;
  int sold;
  double rating;
  setlistImage(List<String> listImage){
    this.listImage = listImage;
  }
  setRating(double rating){
    this.rating = rating;
  }
  Product(
      {this.productID,
      this.productName,
      this.takeCareOfTree,
      this.longevity,
      this.origin,
      this.temperature,
      this.theAmountOfWater,
      this.price,
      this.height,
      this.plantID,
      this.weight,
      this.fastDelivery,
      this.quantityInStock,
      this.preOrder,
      this.created,
      this.address,
        this.category,
      this.accountID,
      this.liked,
      this.sold,
      this.watched,});
  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productID: json['productID'],
    productName:  json['productName'],
    takeCareOfTree : json['takeCareOfTree'],
    longevity: json['longevity'],
    origin: json['origin'],
    temperature:  json['temperature'],
    theAmountOfWater:  json['theAmountOfWater'],
    price : json['price'],
    height: json['height'],
    plantID: json['plantID'],
    weight:  json['weight'],
    fastDelivery : json['fastDelivery'],
    quantityInStock :  json['quantityInStock'],
    preOrder : json['preOrder'],
    created: json['created'],
    address: json['address'],
    accountID: json['accountID'],
    category: json['category'],
    sold: json['sold'],
    watched: json['watched'],
    liked: json['liked'],
  );

}