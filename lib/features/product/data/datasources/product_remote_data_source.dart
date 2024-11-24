import 'dart:async';
import 'dart:convert';
import 'package:flutter_stylish/core/util/api.dart';
import 'package:flutter_stylish/core/util/http.dart';
import '../models/product_model.dart';
// TODO CODE-REVIEW the code review that added must applying on whole file
abstract class RemoteDataSource {
  // TODO CODE-REVIEW use response entity not model
  // TODO : use should know the difference between entity and model
  Future<List<ProductModel>> getProducts({int page, int limit});
}

class RemoteDataSourceImpl implements RemoteDataSource {

  @override
  Future<List<ProductModel>> getProducts({int page = 1, int limit = 4}) async {
    try {
      // Fetch all products from the API
      
      final response = await apiClient
          .get(products)
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
