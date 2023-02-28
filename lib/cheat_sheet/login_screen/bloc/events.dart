abstract class LoginEvent {}

class LoadInitialDataEvent extends LoginEvent {}

class PefromLoginEvent extends LoginEvent {
  final String login;
  final String password;
  final bool isEmailingEnabled;
  final String greetingText;

  PefromLoginEvent({
    required this.login,
    required this.password,
    required this.isEmailingEnabled,
    required this.greetingText,
  });
}
