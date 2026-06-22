abstract class AuthState {}

class AuthInitial extends AuthState{}

class AuthSuccess extends AuthState {
  final String username;
  AuthSuccess(this.username);
}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  String message = '';
  AuthFailure(this.message);
}