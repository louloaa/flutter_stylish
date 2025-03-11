import 'package:stylish/features/product/data/datasources/product_remote_data_source.dart';
import 'package:stylish/features/product/domain/entities/product.dart';
import 'package:stylish/features/product/domain/repositories/product_repository.dart';
import '../models/product_model.dart';
class ProductRepositoryImpl implements ProductRepository {
  final RemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts({int page = 1, int limit = 4}) async {
    // Fetch the products from the remote data source, passing the page and limit
    final List<ProductModel> productModels = await remoteDataSource.getProducts(page: page, limit: limit);

    // Map ProductModel to Product
    return productModels.map((productModel) {
      return Product(
        id: productModel.id,
        title: productModel.title.isNotEmpty ? productModel.title : 'Unknown',
        imageUrl: productModel.imageUrl.isNotEmpty
            ? productModel.imageUrl
            : 'default_image_url',
        price: productModel.price,
        description: productModel.description.isNotEmpty
            ? productModel.description
            : 'No description available',
      );
    }).toList();
  }
}
