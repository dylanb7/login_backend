part of '../login_backend.dart';

enum EmailLevel {
  basic,
}

class Email extends FormzInput<String, FieldError> {
  final EmailLevel level;

  static final _emailRegExp = {
    EmailLevel.basic:
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'),
  };

  Email.pure([EmailLevel level = EmailLevel.basic])
      : this.level = level,
        super.pure('');

  Email.dirty([EmailLevel level = EmailLevel.basic, String value = ''])
      : this.level = level,
        super.dirty(value);

  @override
  FieldError? validator(String value) {
    if (value.isEmpty) return FieldError.empty;
    return _emailRegExp[level]!.hasMatch(value) ? null : FieldError.invalid;
  }
}
