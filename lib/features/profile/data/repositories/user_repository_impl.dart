// data/repositories/user_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:stylish/core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> getUserProfile(int userId) async {
    try {
      final userModel = await remoteDataSource.getUserProfile(userId);
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(""));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserProfile(UserEntity user) async {
    try {
      await remoteDataSource.updateUserProfile(UserModel(
        username: user.username,
        password: user.password,
        city: user.city,
        phone: user.phone,
      ));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(""));
    }
  }
}
