// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';

// Unified base class for all product states
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

// Initial state when no product fetching has started
class ProductInitial extends ProductState {}

// Loading state when products are being fetched
class ProductLoading extends ProductState {}

// Loaded state with fetched products (used for home, trending, and general)
class ProductLoaded extends ProductState {
  final List<Product> products;
  final int currentPage;
  final bool hasMore; // Indicate if there are more products available

  const ProductLoaded(this.products, this.currentPage, {this.hasMore = true}); // Add hasMore to the constructor

  @override
  List<Object> get props => [products, currentPage, hasMore];
}

// Error state when fetching products fails
class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
// bloc/navigation_state.dart
class HomeState extends ProductState {}

class TrendingState extends ProductState {}

class ProudctsState extends ProductState {}

class CheckoutState extends ProductState {}



