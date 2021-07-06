part of '../login_backend.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthUserChanged extends AuthEvent {
  
  const AuthUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}