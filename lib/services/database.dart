import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/user.dart';

class Database{
  final Firestore  _firestore = Firestore.instance;

  // create account user.
  Future <String> createUser(User user) async{
    String retVal =  "error";
    try{
      await _firestore.collection("users").document(user.uid).setData(
        {
          'uid' : user.uid,
          'phoneNumber' : user.phoneNumber,
          'userName' :user.userName,
          'gender' : user.gender,
          'dob' : user.dob,
          'email': user.email,
          'urlImage' : "https://i.dlpng.com/static/png/6866112_preview.png",
          'accountCreated': Timestamp.now(),
        }
      );
      retVal = "success";
    }catch(e){
      print(e);
    }
    return retVal;
  }
  Future<String> updateUser(User user) async{
    String  retval = "Error";
    try{
      await _firestore.collection("users").document(user.getUid()).updateData({
        'userName' :user.userName,
        'gender' : user.gender,
        'dob' : user.dob,
        'email': user.email,
      });
    }catch(e){
      print(e);
    }

  }
  // get User Info

  Future <dynamic> getUserInfo(String uid) async{
    User retVal =new User();
    try{
       DocumentSnapshot _docSnapshot = await Firestore.instance.collection("users").document(uid).get();
       if (!_docSnapshot.exists)
         {
           print("null");
           return null;
         }
       else {
         retVal.uid = uid;
         retVal.userName = _docSnapshot.data["userName"];
         retVal.phoneNumber = _docSnapshot.data["phoneNumber"];
         retVal.email = _docSnapshot.data["email"];
         retVal.accountCreated = _docSnapshot.data["accountCreated"];
         retVal.dob = _docSnapshot.data["dob"];
         retVal.gender = _docSnapshot.data["gender"];
         retVal.urlImage  = _docSnapshot.data["urlImage"];
         return retVal;
       }
    }catch(e) {
      print(e);
    }
  }

  // addAddress
  Future<String> addAddress(String uid, String address, String phoneNumber, String name) async{
    String ret= 'success';
    try{
      CollectionReference ref = Firestore.instance.collection("users").document(uid).collection("delivers");
      DocumentReference document = ref.document();
      document.setData({
        'uid': document.documentID,
        'address' : address,
        'phoneNumber': phoneNumber,
        'name': name
      });
      ret=document.documentID.toString();
    }catch(e){
      ret = e.toString();
    }
    return ret;
  }
  // getAllAddress
  getAllAddress(String uid) {
    return Firestore.instance.collection("users").document(uid).collection("delivers").getDocuments();
  }
  // update
  Future<String> updateDAddress(String userUid,String deliverID, String address, String phoneNumber, String name) async{
    String ret= 'success';
    try{
      _firestore.collection("users").document(userUid).collection("delivers").document(deliverID).updateData({
        'address' : address,
        'phoneNumber': phoneNumber,
        'name': name
      });

    }catch(e){
      ret = e.toString();
    }
    return ret;
  }

  // delete
  Future<String> deleteDeliver(String uid, String documentID) async{
    try{
      _firestore.collection("users").document(uid).collection("delivers").document(documentID).delete().then((value){
        return "Deleted";
      });
    }catch(e){
      return e.toString();
    }
  }
  // delete User
  Future<String> deleteUser(String uid) async{
    
    try{

      _firestore.collection("users").document(uid).delete().then((value){
        return "Account User has been deleted";
      });
    }catch(e){
      return e.toString();
    }
  }
  getUser(String uid){
    return _firestore.collection('users').where('uid',  isEqualTo: uid).getDocuments();
  }
}