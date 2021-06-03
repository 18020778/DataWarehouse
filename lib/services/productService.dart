import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/product.dart';

class ProductService {
  final Firestore _firestore = Firestore.instance;

  Future <String> createProduction(Product product) async {
    String retVal = "error";
    try {
      CollectionReference ref = Firestore.instance.collection("products");
      DocumentReference document = ref.document();
      document.setData({
        'productID': document.documentID,
        'productName': product.productName,
        'takeCareOfTree': product.takeCareOfTree,
        'longevity': product.longevity,
        'origin': product.origin,
        'temperature': product.temperature,
        'theAmountOfWater': product.theAmountOfWater,
        'price': product.price,
        'height': product.height,
        'plantID': product.plantID,
        'weight': product.weight,
        'fastDelivery': product.fastDelivery,
        'quantityInStock': product.quantityInStock,
        'preOrder': product.preOrder,
        'created': Timestamp.now(),
        'accountID': product.accountID,
        'address': product.address,
        'category': product.category,
        'sold': 0,
        'liked': 0,
        'watched': 0,
      });
      retVal = document.documentID;
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  getProductByID(String productID) {
    return _firestore.collection("products").where(
        'productID', isEqualTo: productID).getDocuments();
  }

  getAllProduct() {
    return Firestore.instance
        .collection("products")
        .getDocuments();
  }

  getAllProductByPersonal(String uid) {
    return Firestore.instance
        .collection("products")
        .where("accountID", isEqualTo: uid)
        .getDocuments();
  }

  top10NewProduct() {
    return Firestore.instance
        .collection("products")
        .orderBy("created", descending: true)
        .limit(10)
        .getDocuments();
  }


  top10ProductOrderByCategory(String category) {
    return Firestore.instance
        .collection("products")
        .where("category", isEqualTo: category)
        .limit(10)
        .getDocuments();
  }

  getImageProduct(String productID) {
    return Firestore.instance
        .collection("products")
        .document(productID)
        .collection("imageProduct")
        .where("productID", isEqualTo: productID)
        .getDocuments();
  }

  getAllProductGroupByPlant(String plantID) {
    return _firestore.collection("products").where(
        "plantID", isEqualTo: plantID).getDocuments();
  }

  Future<String> updateLike(String productId, bool isAdd) async {
    int number = 0;
    getProductByID(productId).then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        docs.documents.forEach((element) {
          number = element['liked'];
        });
        if (isAdd)
          number ++;
        else
          number --;
        try {
          _firestore.collection("products").document(productId).updateData({
            'liked': number
          });
          return 'success';
        } catch (e) {
          return e.toString();
        }
      }
      else {
        if (isAdd)
          number ++;
        else
          number --;
        try {
          _firestore.collection("products").document(productId).updateData({
            'liked': number
          });
          return 'success';
        } catch (e) {
          return e.toString();
        }
      }
    });
  }

  updateWatched(String productId, int number) {
    try {
      _firestore.collection("products").document(productId).updateData({
        'watched': number + 1
      });
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }
  // updateRating(String productId, double number) {
  //   try {
  //     _firestore.collection("products").document(productId).updateData({
  //       'watched': number
  //     });
  //     return 'success';
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }
  Future<String> addFeedBack(String productID, String uid, double rating, String feedBack) async{
    try{
      _firestore.collection("products").document(productID).collection("rating").document(uid)
          .setData({
        'rating' : rating,
        'feedBack' : feedBack
      });
      return 'success';
    }
    catch(e){
      return e.toString();
    }
  }
  updateSold(String productId, int amount) {
    int number = 0;
    getProductByID(productId).then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        docs.documents.forEach((element) {
          number = element['sold'];
        });
        try {
          _firestore.collection("products").document(productId).updateData({
            'sold': number + amount
          });
          return 'success';
        } catch (e) {
          return e.toString();
        }
      }
      else {
        try {
          _firestore.collection("products").document(productId).updateData({
            'sold': number + 1
          });
          return 'success';
        } catch (e) {
          return e.toString();
        }
      }
    });
  }

  getAllProductMatchesCategory(String queryString)  {

    return _firestore.collection("products").where(
        "category", isEqualTo: queryString)
        .getDocuments();
  }

  getAllProductMatchesPlantName(String queryString)  {
    return _firestore.collection("products").where(
        "plantID", isEqualTo: queryString).getDocuments();
  }

  top10InterestedProducts(){
    return Firestore.instance
        .collection("products")
        .orderBy("sold",descending: true)
        .limit(10)
        .getDocuments();
  }

  getALlRating(String productID){
    return _firestore.collection("products").document(productID)
        .collection("rating").getDocuments();
  }
}