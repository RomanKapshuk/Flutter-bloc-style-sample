class VerificationError {
  final String warningText;

  VerificationError({
    required this.warningText,
  });
}

class ValidationError {
  // 'login'/'password'
  final String field;
  final String reason;
  final String suggestion;

  ValidationError({
    required this.field,
    required this.reason,
    required this.suggestion,
  });
}
