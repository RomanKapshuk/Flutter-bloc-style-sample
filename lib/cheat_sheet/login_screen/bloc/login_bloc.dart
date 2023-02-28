import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cheat_sheet/extensions.dart';
import 'package:test/cheat_sheet/login_screen/bloc/events.dart';
import 'package:test/cheat_sheet/login_screen/bloc/states.dart';
import 'package:test/cheat_sheet/login_screen/errors.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitState()) {
    on<LoadInitialDataEvent>((event, emit) {
      emit(InitialDataLoadedState(
        loginHint: 'e.g. \'CoolDude3000\'',
      ));
    });

    on<PefromLoginEvent>((event, emit) async {
      emit(LoadingState());

      await Future.delayed(const Duration(seconds: 3));

      final verifyLoginError = verifyUserNotExist(event.login);

      if (verifyLoginError != null) {
        emit(VerificationErrorState(verifyLoginError));
        return;
      }

      final validationErrors = <ValidationError>[];

      validationErrors
        ..addIfNotNull(validateLogin(event.login))
        ..addIfNotNull(validatePassword(event.password));

      if (validationErrors.isNotEmpty) {
        emit(ValidationErrorState(errors: validationErrors));
        return;
      }

      emit(LoginSuccessState());
    });
  }

  VerificationError? verifyUserNotExist(String login) {
    if (login.toLowerCase() == 'exist') {
      return VerificationError(warningText: 'User with login $login already exist');
    }
    return null;
  }

  ValidationError? validateLogin(String login) {
    if (login.isEmpty) {
      return ValidationError(
        field: 'login',
        reason: 'empty',
        suggestion: 'Fill login field',
      );
    }
    return null;
  }

  ValidationError? validatePassword(String password) {
    if (password.isEmpty) {
      return ValidationError(
        field: 'password',
        reason: 'empty',
        suggestion: 'Fill password field',
      );
    }

    if (password.length < 3) {
      return ValidationError(
        field: 'password',
        reason: 'short',
        suggestion: 'Password should be at least 3 symbols',
      );
    }

    if (!password.contains(r'\d')) {
      return ValidationError(
        field: 'password',
        reason: 'insecure',
        suggestion: 'Password should contain at least 1 digit',
      );
    }
    return null;
  }
}
