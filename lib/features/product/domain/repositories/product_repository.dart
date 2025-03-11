import 'package:stylish/features/product/domain/entities/product.dart';
abstract class ProductRepository {
  Future<List<Product>> getProducts({int page = 1, int limit = 4}); // Default limit set to 4
}

