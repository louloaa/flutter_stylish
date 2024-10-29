// presentation/bloc/user_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_user_profile.dart';
import '../../domain/usecases/update_user_profile.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserProfile getUserProfile;
  final UpdateUserProfile updateUserProfile;

  UserBloc({required this.getUserProfile, required this.updateUserProfile})
      : super(UserInitial()) {
    on<FetchProfile>((event, emit) async {
      emit(UserLoading());
      final result = await getUserProfile(10); // Fetching profile for userId = 1
      result.fold(
        (failure) => emit(UserError("Error loading user profile")),
        (user) => emit(UserLoaded(user)),
      );
    });

    on<SaveProfile>((event, emit) async {
      emit(UserLoading());
      final result = await updateUserProfile(event.updatedUser);
      result.fold(
        (failure) => emit(UserError("Error saving profile")),
        (success) {
          emit(UserLoaded(event.updatedUser)); // Emit the updated profile to refresh the UI
        },
      );
    });
  }
}

