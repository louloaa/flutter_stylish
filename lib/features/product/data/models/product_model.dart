import 'package:flutter_stylish/features/product/domain/entities/product.dart';
class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0, // Provide a default value if `id` is null
      title: json['title'] ?? 'Unknown', // Provide default if `title` is null
      imageUrl: json['image'] ?? '', // Handle null for `imageUrl`
      price: (json['price'] as num?)?.toDouble() ?? 0.0, // Handle null safely
      description:
          json['description'] ?? 'No description available', // Provide default
    );
  }
}
