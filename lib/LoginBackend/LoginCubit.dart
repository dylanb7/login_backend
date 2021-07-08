part of '../login_backend.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authRepo;

  final EmailLevel _emailLevel;

  final PasswordLevel _passwordLevel;

  LoginCubit(this._authRepo,
      {EmailLevel emailLevel = EmailLevel.basic,
      PasswordLevel passwordLevel = PasswordLevel.LN8C})
      : this._emailLevel = emailLevel,
        this._passwordLevel = passwordLevel,
        super(LoginState(Email.pure(emailLevel), Password.pure(passwordLevel),
            FormzStatus.pure));

  void emailChanged(String val) {
    final Email email = Email.dirty(_emailLevel, val);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String val) {
    final Password password = Password.dirty(_passwordLevel, val);
    emit(state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
    ));
  }

  Future<void> logInWithCredentials() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authRepo.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
