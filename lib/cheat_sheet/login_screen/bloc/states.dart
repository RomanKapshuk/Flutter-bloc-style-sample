import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:test/cheat_sheet/login_screen/errors.dart';

abstract class LoginState {}

class InitState implements LoginState {}

class InitialDataLoadedState implements LoginState {
  final String loginHint;

  InitialDataLoadedState({
    required this.loginHint,
  });
}

class LoadingState implements LoginState {}

class LoginSuccessState implements LoginState {}

class VerificationErrorState implements LoginState {
  final VerificationError error;

  VerificationErrorState(this.error);
}

class ValidationErrorState implements LoginState {
  final List<ValidationError> errors;

  ValidationErrorState({
    required this.errors,
  });
}

