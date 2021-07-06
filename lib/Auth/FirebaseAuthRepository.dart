part of '../login_backend.dart';

class FirebaseAuthRepository extends AuthenticationRepository {
  final auth.FirebaseAuth _auth;

  FirebaseAuthRepository({required auth.FirebaseAuth? firebaseAuth})
      : _auth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } on Exception {
      throw LogOutFailure();
    }
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw SignUpFailure();
    }
  }

  @override
  Stream<User> get user => _auth.authStateChanges().map((_user) => _user == null
      ? User.empty
      : User(id: _user.uid, email: _user.email, name: _user.displayName));
}
