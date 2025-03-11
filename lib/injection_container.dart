import 'package:stylish/features/auth&splash/data/datasources/auth_remote_data_source.dart';
import 'package:stylish/features/auth&splash/data/repositories/auth_repository_impl.dart';
import 'package:stylish/features/auth&splash/domain/repositories/auth_repository.dart';
import 'package:stylish/features/auth&splash/domain/usecases/sign_in_usecase.dart';
import 'package:stylish/features/auth&splash/domain/usecases/sign_up_usecase.dart';
import 'package:stylish/features/product/data/datasources/product_remote_data_source.dart';
import 'package:stylish/features/product/data/repositories/product_repository.dart';
import 'package:stylish/features/product/domain/repositories/product_repository.dart';
import 'package:stylish/features/product/domain/usecases/getproducts.dart';
import 'package:stylish/features/profile/data/datasources/remote_data_source.dart';
import 'package:stylish/features/profile/data/repositories/user_repository_impl.dart';
import 'package:stylish/features/profile/domain/repositories/user_repository.dart';
import 'package:stylish/features/profile/domain/usecases/get_user_profile.dart';
import 'package:stylish/features/profile/domain/usecases/update_user_profile.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// Import your classes here

final sl = GetIt.instance;

Future<void> init() async {
  // Register HTTP client
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Register remote data sources
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  // Register repositories with explicit types
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl()));

  // Register use cases
  sl.registerLazySingleton<GetProductsUseCase>(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(sl()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl()));
  sl.registerLazySingleton<GetUserProfile>(() => GetUserProfile(sl()));
  sl.registerLazySingleton<UpdateUserProfile>(() => UpdateUserProfile(sl()));
}
