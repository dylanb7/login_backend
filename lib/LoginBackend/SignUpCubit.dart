part of '../login_backend.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthenticationRepository _authRepo;

  final EmailLevel emailLevel;

  final PasswordLevel passwordLevel;

  SignUpCubit(this._authRepo,
      {EmailLevel emailLevel = EmailLevel.basic,
      PasswordLevel passwordLevel = PasswordLevel.LN8C})
      : this.emailLevel = emailLevel,
        this.passwordLevel = passwordLevel,
        super(SignUpState(Email.pure(emailLevel), Password.pure(passwordLevel),
            ConfirmedPassword.pure(), FormzStatus.pure));

  void emailChanged(String val) {
    final Email email = Email.dirty(emailLevel, val);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword
      ])
    ));
  }

  void passwordChanged(String value) {
    final Password password = Password.dirty(passwordLevel, value);
    final ConfirmedPassword confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        password,
        confirmedPassword,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authRepo.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

}
