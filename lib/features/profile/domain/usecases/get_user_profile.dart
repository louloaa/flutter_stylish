// domain/usecases/get_user_profile.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_stylish/core/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';


class GetUserProfile {
  final UserRepository repository;

  GetUserProfile(this.repository);

  Future<Either<Failure, UserEntity>> call(int userId) async {
    return await repository.getUserProfile(userId);
  }
}
