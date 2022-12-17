part of 'authentication_cubit.dart';

enum LoginStatus { initial, loading, success, failure }

class AuthenticationState {
  final LoginStatus status;
  final User? user;
  final Exception? exception;

  const AuthenticationState({
    this.status = LoginStatus.initial,
    this.user,
    this.exception,
  });

  AuthenticationState copyWith({
    LoginStatus? status,
    User? user,
    Exception? exception,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
      exception: exception ?? this.exception,
    );
  }
}
