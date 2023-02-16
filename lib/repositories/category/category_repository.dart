import 'package:blocecommerce/models/models.dart';
import 'package:blocecommerce/repositories/category/base_category_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepository extends BaseCategoryRepository {
  final FirebaseFirestore _firebaseFirestore;
  CategoryRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  //How to get datas from firebase without any restrictions
  @override
  Stream<List<Category>> getAllCategories() {
    return _firebaseFirestore.collection("categories").snapshots().map((snap) {
      return snap.docs.map((e) => Category.fromSnapshot(e)).toList();
    });
  }
}
