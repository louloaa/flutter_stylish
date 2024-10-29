import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
abstract class RemoteDataSource {
  Future<List<ProductModel>> getProducts({int page, int limit});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts({int page = 1, int limit = 4}) async {
    try {
      // Fetch all products from the API
      final url = Uri.parse('https://fakestoreapi.com/products');
      final response = await client
          .get(url)
          .timeout(const Duration(seconds: 10)); // Handle request timeout

      if (response.statusCode == 200) {
        // Decode the response body into a list of products
        final List<dynamic> productList = json.decode(response.body);

        // Check if the productList is empty
        if (productList.isEmpty) {
          throw Exception('No products found');
        }

        // Implement pagination by slicing the products list
        final startIndex = (page - 1) * limit;
        final endIndex = startIndex + limit;
        final paginatedList = productList.sublist(
          startIndex,
          endIndex > productList.length ? productList.length : endIndex,
        );

        // Parse the paginated list into ProductModel objects
        return paginatedList
            .whereType<Map<String, dynamic>>() // Ensure valid JSON objects
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load products. Status code: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request to the server timed out');
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }
}
