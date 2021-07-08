part of '../login_backend.dart';

enum PasswordLevel {
  LN8C,
}

class Password extends FormzInput<String, FieldError> {

  final PasswordLevel securityLevel;

  static final _passwordRegExp = {
    PasswordLevel.LN8C: RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'),
  };

  const Password.pure([PasswordLevel sec = PasswordLevel.LN8C])
      : securityLevel = sec,
        super.pure('');

  const Password.dirty([PasswordLevel sec = PasswordLevel.LN8C, String value = ''])
      : securityLevel = sec,
        super.dirty(value);

  @override
  FieldError? validator(String value) {
    if (value.isEmpty)
      return FieldError.empty;
    return _passwordRegExp[this.securityLevel]!.hasMatch(value)
        ? null
        : FieldError.invalid;
  }

}
