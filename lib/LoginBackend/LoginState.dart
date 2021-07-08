part of '../login_backend.dart';

class LoginState extends Equatable {

  final Email email;

  final Password password;

  final FormzStatus status;

  const LoginState(this.email, this.password, this.status);

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
  }) {
    return LoginState(
      email ?? this.email,
      password ?? this.password,
      status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, password, status];

}