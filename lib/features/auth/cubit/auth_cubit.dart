import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/storage/auth_local_storage.dart';
import 'package:weather_app/features/auth/cubit/auth_state.dart';
import 'package:weather_app/features/auth/services/auth_service.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthService _authService = AuthService();

  void checkAuthStatus() async {
    final bool isLogined = await _authService.isLogined();
    if (isLogined) {
      emit(AuthSuccess());
    }
    else {
      emit(AuthFailure("Session expired. Please login again."));
      _authService.logout();
    }
  }

  Future<void> login(String username, String password, bool rememberMe) async {
    if (username.isEmpty || password.isEmpty) {
      emit(AuthFailure("Username and Password cannot be empty!"));
      return;
    }
    
    emit(AuthLoading());

    try {
      final isSuccess = await _authService.login(username, password, rememberMe);
      if (isSuccess) {
        emit(AuthSuccess());
      }
      else {
        emit(AuthFailure("Invalid Username or Password. Please try again."));
      }
    }
    catch (e) {
      emit(AuthFailure("An error occurred. Please try again."));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _authService.logout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure("An error occurred. Please try again."));
    }
  }

  Map <String, String>? getSavedCredentials() {
    if (AuthLocalStorage.getRememberMeFlag()) {
      return {
        'username': AuthLocalStorage.getUsername(),
        'password': AuthLocalStorage.getPassword()
      };
    }
    return null;
  }
}