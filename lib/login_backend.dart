library login_backend;


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'User.dart';
part 'AuthSection.dart';
part 'Interface/AuthBloc.dart';
part 'Interface/AuthEvent.dart';
part 'Interface/AuthState.dart';
part 'Auth/AuthenticationRepository.dart';
part 'Auth/FirebaseAuthRepository.dart';