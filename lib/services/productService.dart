import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/models/product.dart';

class ProductService{
  final Firestore  _firestore = Firestore.instance;

  Future <String> createProduction(Product product) async{
    String retVal =  "error";
    try{
      CollectionReference ref = Firestore.instance.collection("products");
      DocumentReference document = ref.document();
      document.setData({
        'productID': document.documentID,
        'productName':  product.productName,
        'takeCareOfTree' : product.takeCareOfTree,
        'longevity': product.longevity,
        'origin': product.origin,
        'temperature':  product.temperature,
        'theAmountOfWater':  product.theAmountOfWater,
        'price' : product.price,
        'height': product.height,
        'plantID': product.plantID,
        'weight':  product.weight,
        'fastDelivery' : product.fastDelivery,
        'quantityInStock' :  product.quantityInStock,
        'preOrder' : product.preOrder,
        'created': Timestamp.now(),
        'accountID' : product.accountID,
        'address': product.address,
        'category' : product.category
      });
      retVal = document.documentID;
    }catch(e){
      print(e);
    }
    return retVal;
  }
  getProductByID(String productID) {
    return _firestore.collection("products").where('productID', isEqualTo: productID).getDocuments();
  }
  getAllProduct(){
    return Firestore.instance
          .collection("products")
          .getDocuments();
  }

  top10NewProduct(){
    return Firestore.instance
        .collection("products")
        .orderBy("created", descending: true)
        .limit(10)
        .getDocuments();
  }


  top10ProductOrderByCategory(String category){
    return Firestore.instance
        .collection("products")
        .where("category", isEqualTo: category)
        .limit(10)
        .getDocuments();
  }
  getImageProduct(String productID){
    return Firestore.instance
          .collection("products")
          .document(productID)
          .collection("imageProduct")
          .where("productID", isEqualTo: productID)
          .getDocuments();
  }

  getAllProductGroupByPlant(String plantID){
    return _firestore.collection("products").where("plantID", isEqualTo: plantID).getDocuments();
  }

}