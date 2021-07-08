part of '../login_backend.dart';

class SignUpState extends Equatable {
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;

  const SignUpState(
    this.email,
    this.password,
    this.confirmedPassword,
    this.status,
  );

  @override
  List<Object> get props => [email, password, confirmedPassword, status];

  SignUpState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
  }) {
    return SignUpState(
      email ?? this.email,
      password ?? this.password,
      confirmedPassword ?? this.confirmedPassword,
      status ?? this.status,
    );
  }
}
