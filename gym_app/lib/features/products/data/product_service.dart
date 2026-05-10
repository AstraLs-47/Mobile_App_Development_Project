// Project imports:
import '../../../core/services/mock_db.dart';
import '../../../core/models/product_model.dart';

class ProductService {
  final MockDB _db = MockDB();

  Future<List<Product>> fetchProducts() async {
    return _db.products.map((p) => Product.fromJson(p)).toList();
  }

  Future<void> addProduct(Product product) async {
    _db.addProduct(product.toJson().map((k, v) => MapEntry(k, v.toString())));
  }

  Future<void> updateProduct(Product product) async {
    _db.updateProduct(product.id, product.toJson().map((k, v) => MapEntry(k, v.toString())));
  }

  Future<void> deleteProduct(String id) async {
    _db.removeProduct(id);
  }
}
