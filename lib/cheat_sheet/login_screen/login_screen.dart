import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test/cheat_sheet/login_screen/bloc/events.dart';
import 'package:test/cheat_sheet/login_screen/bloc/login_bloc.dart';
import 'package:test/cheat_sheet/login_screen/bloc/states.dart';
import 'package:test/cheat_sheet/login_screen/errors.dart';
import 'package:test/cheat_sheet/widgets.dart';

void navigateToLoginScreen(BuildContext context) {
  final screenData = LoginScreenData();
  final bloc = LoginBloc();
  final route = MaterialPageRoute(
      builder: (context) => LoginScreen(
            screenData: screenData,
            bloc: bloc,
          ));
  Navigator.of(context).push(route);
}

class LoginScreenData {
  bool isEmailingEnabled = true;

  final loginFieldData = InputFieldData()..hint = 'e.g. CoolDude3000';
  final passwordFieldData = InputFieldData();
  String greetingText = '';

  VerificationError? verificationError;
}

class LoginScreen extends StatefulWidget {
  final LoginScreenData screenData;
  final LoginBloc bloc;
  const LoginScreen({
    Key? key,
    required this.screenData,
    required this.bloc,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final greetingTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.bloc.add(LoadInitialDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: TextButton(
        child: const Text(
          'back',
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () => Navigator.of(context).pop(),
      )),
      body: BlocConsumer(
        bloc: widget.bloc,
        listener: blocListner,
        builder: (context, state) {
          return Stack(
            children: [
              if (state is LoadingState)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InputField(
                      data: widget.screenData.loginFieldData,
                    ),
                    InputField(
                      data: widget.screenData.passwordFieldData,
                    ),
                    Row(
                      children: [
                        const Text('Enable Emailing'),
                        Switch.adaptive(
                          value: widget.screenData.isEmailingEnabled,
                          onChanged: state is LoadingState
                              ? null
                              : (value) {
                                  setState(() {
                                    widget.screenData.isEmailingEnabled = value;
                                  });
                                },
                        ),
                      ],
                    ),
                    TextField(
                      controller: greetingTextController,
                      onChanged: (value) => widget.screenData.greetingText = value,
                    ),
                    TextButton(
                        child: const Text('LOGIN'),
                        onPressed: state is LoadingState
                            ? null
                            : () {
                                widget.bloc.add(PefromLoginEvent(
                                  isEmailingEnabled: widget.screenData.isEmailingEnabled,
                                  login: widget.screenData.loginFieldData.value,
                                  password: widget.screenData.passwordFieldData.value,
                                  greetingText: widget.screenData.greetingText,
                                ));
                              }),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    greetingTextController.dispose();
    super.dispose();
  }

  blocListner(context, state) {
    if (state is LoadingState) {
      widget.screenData
        ..loginFieldData.enabled = false
        ..passwordFieldData.enabled = false;
    } else {
      widget.screenData
        ..loginFieldData.enabled = true
        ..passwordFieldData.enabled = true;
    }

    if (state is InitialDataLoadedState) {
      widget.screenData.loginFieldData.hint = state.loginHint;
    }
    if (state is VerificationErrorState) {
      widget.screenData.verificationError = state.error;
    }
    if (state is ValidationErrorState) {
      widget.screenData.loginFieldData.error = state.errors.firstWhereOrNull((it) => it.field == 'login');
      widget.screenData.passwordFieldData.error = state.errors.firstWhereOrNull((it) => it.field == 'password');
    }
  }
}
