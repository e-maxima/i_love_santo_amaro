import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "nome";
  static const PICTURE = "imagem";
  static const PRICE = "preco";
  static const DESCRIPTION = "descricao";
  static const CATEGORY = "categoria";

  String _id;
  String _name;
  String _picture;
  String _description;
  String _category;
  int _price;

  String get id => _id;

  String get name => _name;

  String get picture => _picture;

  String get category => _category;

  String get description => _description;

  int get price => _price;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _description = snapshot.data[DESCRIPTION] ?? " ";
    _price = snapshot.data[PRICE].floor();
    _category = snapshot.data[CATEGORY];
    _name = snapshot.data[NAME];
    _picture = snapshot.data[PICTURE];
  }
}
