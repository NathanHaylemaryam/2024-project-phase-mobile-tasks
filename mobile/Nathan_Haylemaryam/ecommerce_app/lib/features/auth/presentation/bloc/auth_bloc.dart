import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/check_auth_status.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/signup.dart';
import '../pages/home_screen.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final SignUp signUp;
  final Logout logout;
  final GetCurrentUser getCurrentUser;
  final CheckAuthStatus checkAuthStatus;

  AuthBloc({
    required this.login,
    required this.signUp,
    required this.logout,
    required this.getCurrentUser,
    required this.checkAuthStatus,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignUpEvent>(_onSignUp);
    on<LogoutEvent>(_onLogout);

  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await login(LoginParams(
      email: event.email,
      password: event.password,
    ));

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (authResponse) => emit(Authenticated(authResponse.user)),
    );
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signUp(SignUpParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (authResponse) => emit(Authenticated(authResponse.user)),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await logout(NoParams());

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (_) => emit(Unauthenticated()),
    );
  }


}