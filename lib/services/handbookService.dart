import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/models/articles.dart';
import 'package:first_app/models/handBook.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/database.dart';

class handbookService {
  final _firebaseStore = Firestore.instance;

  getAllHandBook() {
    return Firestore.instance
        .collection("handbooks")
        .orderBy("timeCreated", descending: true)
        .getDocuments();
  }

  // list  handbook of user
  getHandBook(String uid) {
    return Firestore.instance
        .collection("handbooks")
        .where('userUid', isEqualTo: uid)
        .getDocuments();
  }

  Future<dynamic> gethandBookByUid(String handbookUid) async {
    handBook retVal = new handBook();
    try {
      _firebaseStore.collection("handbooks").document(handbookUid).get().then((
          value) {
        if (value == null) {
          return null;
        } else {
          retVal.setHandBookId(handbookUid);
          retVal.setContent(value['content']);
          retVal.setImageUrl(value['imageUrl']);
          retVal.setPlantName(value['plantName']);
          retVal.setTitle(value['title']);
          retVal.setTimeCreated(value['timeCreated']);
          retVal.setUserUid(value['userUid']);
        }
      });

      return retVal;
    } catch (e) {
      return e.toString();
    }
  }

  CountTotolHandBook(String userUid) {
    return _firebaseStore.collection("handbooks")
        .where("userUid", isEqualTo: userUid)
        .getDocuments();
  }
}