// domain/usecases/update_user_profile.dart
import 'package:dartz/dartz.dart';
import 'package:stylish/core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';


class UpdateUserProfile {
  final UserRepository repository;

  UpdateUserProfile(this.repository);

  Future<Either<Failure, void>> call(UserEntity user) async {
    return await repository.updateUserProfile(user);
  }
}
