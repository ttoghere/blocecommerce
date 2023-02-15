import 'package:blocecommerce/models/models.dart';

abstract class BaseProductRepository {
  Stream<List<Product>> getAllProducts();
}
