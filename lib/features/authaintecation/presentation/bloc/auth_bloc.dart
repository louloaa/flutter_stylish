import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stylish/core/util/logger.dart';
import 'package:flutter_stylish/features/authaintecation/domain/entities/user_request_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  emit(AuthLoading()); // Emit loading state to indicate ongoing sign-in process

  try {
    // Create a UserRequestEntity with event's username and password
    final userRequest = UserRequestEntity(
      username: event.username,
      password: event.password,
    );

    // Call the signIn method in the use case, which now returns a token if successful
    final token = await signInUseCase.execute(userRequest);

    if (token != null && token.isNotEmpty) {
      // Store the token in SharedPreferences if the token is valid
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      
      logger.i('Token stored in SharedPreferences: $token');
      emit(AuthSuccess()); // Emit success state if sign-in was successful
    } else {
      logger.w('Token is null or empty');
      emit(AuthError("Invalid username or password")); // Emit error state if token is null or empty
    }
  } on UserNotFoundException catch (e) {
    logger.e('User not found: ${e.toString()}');
    emit(AuthError("User not found or invalid credentials"));
  } catch (e) {
    logger.e('Unexpected error: ${e.toString()}');
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
