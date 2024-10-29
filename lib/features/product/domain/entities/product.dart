class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  // Constructor for ProductEntity
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  // Factory method to create ProductEntity from Product
  factory Product.fromProduct(Product product) {
    return Product(
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
  }
}
