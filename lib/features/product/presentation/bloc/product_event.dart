// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

// Unified event class for all product-related events
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

// Event for fetching home products
class FetchHomeProducts extends ProductEvent {}

// Event for fetching trending products
class FetchTrendingProducts extends ProductEvent {}

// Event for fetching all general products
class FetchAllProducts extends ProductEvent {}

class FetchCheckout extends ProductEvent {}

class NavigateToHomeEvent extends ProductEvent {}

class NavigateTrendingEvent extends ProductEvent {}

class NavigateProudctsEvent extends ProductEvent {}

class NavigateCheckoutEvent  extends ProductEvent {}
