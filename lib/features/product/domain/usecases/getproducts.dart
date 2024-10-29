import 'package:flutter_stylish/features/product/domain/entities/product.dart';
import 'package:flutter_stylish/features/product/domain/repositories/product_repository.dart';
class GetProductsUseCase {
  final ProductRepository repository;

  // Constructor
  GetProductsUseCase(this.repository);

  // Method to fetch products, with optional 'page' and 'limit' parameters
  Future<List<Product>> call({int page = 1, int limit = 4}) async {
    return await repository.getProducts(page: page, limit: limit);
  }
}
