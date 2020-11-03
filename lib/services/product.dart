import 'package:ILoveSantoAmaro/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductServices {
  String collection = "produtos";
  Firestore _firestore = Firestore.instance;

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.documents) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> searchProducts({String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase();
    int i;
    for (i = 1; i < productName.length; i++) {
      searchKey = searchKey + productName[i].toLowerCase();
    }
    print(searchKey);
    return _firestore
        .collection(collection)
        .where("categoria", isEqualTo: searchKey)
        .getDocuments()
        .then((result) {
      List<ProductModel> products = [];
      for (DocumentSnapshot product in result.documents) {
        products.add(ProductModel.fromSnapshot(product));
      }
      print('quant prod ' + result.documents.length.toString());
      return products;
    });
  }
}
