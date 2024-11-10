import 'package:bloc/bloc.dart';
import 'package:flutter_stylish/features/product/domain/usecases/getproducts.dart';
import '../../domain/entities/product.dart';
import 'product_event.dart';
import 'product_state.dart';
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;

  bool hasMore = true; // Indicates if more products are available
  int currentPage = 1; // Tracks the current page for pagination
  List<Product> allProducts = []; // Accumulates loaded products
  final int itemsPerPage = 4; // Number of products per page

  // Constructor
  ProductBloc({required this.getProductsUseCase}) : super(ProductInitial()) {
    // Handle FetchHomeProducts event
    on<FetchHomeProducts>((event, emit) async {
      await _handleFetchProducts(emit, event);
    });

    // Handle FetchTrendingProducts event
    on<FetchTrendingProducts>((event, emit) async {
      await _handleFetchProducts(emit, event);
    });

    // Handle FetchAllProducts event
    on<FetchAllProducts>((event, emit) async {
      await _handleFetchProducts(emit, event);
    });

    // Handle navigation events
    on<NavigateToHomeEvent>((event, emit) {
      emit(HomeState()); // Navigate to Home screen
    });

    on<NavigateTrendingEvent>((event, emit) {
      emit(TrendingState()); // Navigate to Trending screen
    });
  }

  // Method to handle fetching products with pagination
  // In your ProductBloc
// In your ProductBloc
  Future<void> _handleFetchProducts(
      Emitter<ProductState> emit, ProductEvent event) async {
    if (state is ProductLoading) return;

    emit(ProductLoading()); // Show loading indicator
    try {
      // Fetch products using the use case, passing in pagination parameters like page number.
      final products = await getProductsUseCase(page: currentPage);

      // Determine if there are more products to load based on the number of fetched products
      bool hasMore = products.length >= 4; // Adjust based on your needs

      // TODO CODE-REVIEW for best practice you can use copy with method instead of generate new state every time
      // TODO CODE-REVIEW how  store the previous data state ?
      // Emit the loaded state with the currentPage and hasMore flag
      emit(ProductLoaded(products, currentPage,
          hasMore: hasMore)); // Pass hasMore here

      // Increment the page count for the next fetch
      currentPage += 1;
    } catch (e) {
      emit(ProductError(e.toString())); // Emit error state on failure
    }
  }
}
