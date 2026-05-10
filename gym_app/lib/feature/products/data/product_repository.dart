import '../../../core/data/mock_db.dart';
import '../../../core/models/product_model.dart';

class ProductRepository {
  final MockDB _db = MockDB();

  List<Product> getProducts() =>
      _db.products.map((p) => Product.fromJson(p)).toList();

  void addProduct(Product product) {
    _db.addProduct(product.toJson().map((k, v) => MapEntry(k, v.toString())));
  }

  void updateProduct(String id, Product product) {
    _db.updateProduct(
      id,
      product.toJson().map((k, v) => MapEntry(k, v.toString())),
    );
  }

  void deleteProduct(String id) {
    _db.removeProduct(id);
  }
}
