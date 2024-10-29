// presentation/bloc/user_event.dart
import '../../domain/entities/user_entity.dart';

abstract class UserEvent {}

class FetchProfile extends UserEvent {}

class SaveProfile extends UserEvent {
  final UserEntity updatedUser;

  SaveProfile(this.updatedUser);
}
