import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
  }) : super(AuthInitial()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
  }

  void _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final success = await signInUseCase.execute(event.username, event.password);
      if (success) {
        emit(AuthSuccess());
      } else {
        emit(AuthError("Invalid username or password"));
      }
    } on UserNotFoundException {
      emit(AuthError("User not found or invalid credentials"));
    } catch (e) {
      emit(AuthError("An error occurred during sign-in: ${e.toString()}"));
    }
  }

  void _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final success = await signUpUseCase.execute(event.userDetails);
      if (success) {
        emit(AuthSuccess());
      } else {
        emit(AuthError("Sign-up failed"));
      }
    } catch (e) {
      emit(AuthError("An error occurred during sign-up: ${e.toString()}"));
    }
  }
}
