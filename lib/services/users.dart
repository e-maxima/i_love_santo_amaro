import 'dart:async';
import 'package:ILoveSantoAmaro/model/cart_item.dart';
import 'package:ILoveSantoAmaro/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  Firestore _firestore = Firestore.instance;
  String collection = "usuarios";

  void createUser(Map data) {
    print('createUser');

    _firestore.collection(collection).document(data["uid"]).setData({
      "uid": data["uid"],
      "email": data["email"],
      "nome": data["nome"],
      "stripeId": data["stripeId"],
      "cart": []
    });

    //_firestore.collection(collection).document(data["uid"]).setData(data);

    print('createUser - fim');
  }

  Future<UserModel> getUserById(String id) =>
      // _firestore.collection(collection).document(id).get().then((doc) {
      //   return UserModel.fromSnapshot(doc);
      // });

      _firestore.collection(collection).getDocuments().then((result) {
        UserModel usuario;
        for (DocumentSnapshot user in result.documents) {
          if (UserModel.fromSnapshot(user).id.trim() == id.trim()) {
            usuario = UserModel.fromSnapshot(user);
            break;
          }
        }
        return usuario;
      });

  void addToCart({String userId, CartItemModel cartItem}) {
    print('userId ' + userId);
    _firestore.collection(collection).document(userId).updateData({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  void removeFromCart({String userId, CartItemModel cartItem}) {
    _firestore.collection(collection).document(userId).updateData({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }
}
