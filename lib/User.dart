part of 'login_backend.dart';

class User extends Equatable {

  final String id;

  final String? email;

  final String? name;

  const User({required this.id, this.email, this.name});

  static const empty = User(id: '');

  bool get isEmpty => this == empty;

  @override
  List<Object?> get props => [id, email, name];

}