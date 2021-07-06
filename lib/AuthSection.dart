part of 'login_backend.dart';

class AuthSection extends StatelessWidget {
  final AuthenticationRepository _authRepo;

  final Widget login;

  final Widget authenticated;

  const AuthSection({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required Widget login,
    required Widget authenticated,
  })  : _authRepo = authenticationRepository,
        this.login = login,
        this.authenticated = authenticated,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepo,
      child: BlocProvider(
          create: (_) => AuthBloc(authenticationRepository: _authRepo),
          child: context.watch<AuthBloc>().state == AuthState.unauthenticated()
              ? login
              : authenticated),
    );
  }
}
