// domain/repositories/user_repository.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_stylish/core/failures.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUserProfile(int userId);
  Future<Either<Failure, void>> updateUserProfile(UserEntity user);
}
