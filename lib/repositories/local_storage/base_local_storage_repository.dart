import 'package:blocecommerce/models/product_model.dart';
import 'package:hive/hive.dart';

abstract class BaseLocalStorageRepository {
  Future<Box> openBox();
  List<Product> getWishlist(Box box);
  Future<void> addProductToWishlist(Box box, Product product);
  Future<void> removeProductFromWishlist(Box box, Product product);
  Future<void> clearWishlist(Box box);
}
