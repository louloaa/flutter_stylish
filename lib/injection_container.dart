import 'package:flutter_stylish/features/authaintecation/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_stylish/features/authaintecation/data/repositories/auth_repository_impl.dart';
import 'package:flutter_stylish/features/authaintecation/domain/repositories/auth_repository.dart';
import 'package:flutter_stylish/features/authaintecation/domain/usecases/sign_in_usecase.dart';
import 'package:flutter_stylish/features/authaintecation/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_stylish/features/product/data/datasources/product_remote_data_source.dart';
import 'package:flutter_stylish/features/product/data/repositories/product_repository.dart';
import 'package:flutter_stylish/features/product/domain/repositories/product_repository.dart';
import 'package:flutter_stylish/features/product/domain/usecases/getproducts.dart';
import 'package:flutter_stylish/features/profile/data/datasources/remote_data_source.dart';
import 'package:flutter_stylish/features/profile/data/repositories/user_repository_impl.dart';
import 'package:flutter_stylish/features/profile/domain/repositories/user_repository.dart';
import 'package:flutter_stylish/features/profile/domain/usecases/get_user_profile.dart';
import 'package:flutter_stylish/features/profile/domain/usecases/update_user_profile.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
// Import your classes here

final sl = GetIt.instance;
final client = http.Client();
Future<void> init() async {
  // Register HTTP client
  sl.registerLazySingleton<http.Client>(() => client);

  // Register remote data sources
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl());
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());

  // Register repositories with explicit types
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl()));
     
  // Register use cases
  sl.registerLazySingleton<GetProductsUseCase>(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(authRepository: sl()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl()));
  sl.registerLazySingleton<GetUserProfile>(() => GetUserProfile(sl()));
  sl.registerLazySingleton<UpdateUserProfile>(() => UpdateUserProfile(sl()));
}
