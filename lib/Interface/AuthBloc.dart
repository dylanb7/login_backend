part of '../login_backend.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(AuthState.unauthenticated()) {
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);
  }

  final AuthenticationRepository _authenticationRepository;

  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(User user) => add(AuthUserChanged(user));

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthUserChanged) {
      yield _mapUserChangedToState(event, state);
    } else if (event is AuthLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  AuthState _mapUserChangedToState(AuthUserChanged event, AuthState state) {
    return !event.user.isEmpty
        ? AuthState.authenticated(event.user)
        : const AuthState.unauthenticated();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
