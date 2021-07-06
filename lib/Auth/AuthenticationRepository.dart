part of '../login_backend.dart';

class SignUpFailure implements Exception {}

class LogInWithEmailAndPasswordFailure implements Exception {}

class LogOutFailure implements Exception {}

abstract class AuthenticationRepository {

  Stream<User> get user;

  Future<void> signUp({required String email, required String password});

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> logOut();

}
