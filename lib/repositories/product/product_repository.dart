import 'package:blocecommerce/models/models.dart';
import 'package:blocecommerce/repositories/product/base_product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository extends BaseProductRepository {
  final FirebaseFirestore _firebaseFirestore;
  ProductRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;


  //How to get datas from firebase without any restrictions
  @override
  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore
        .collection("products")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => Product.fromSnapshot(e)).toList();
    });
  }
}
