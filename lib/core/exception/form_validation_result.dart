class FormValidationResult {
  final bool isValid;
  final String? errorMessage;

  const FormValidationResult.success() : isValid = true, errorMessage = null;
  const FormValidationResult.error(String message) : isValid = false, errorMessage = message;

  static FormValidationResult combine(List<FormValidationResult> results) {
    for (var result in results) {
      if (!result.isValid) {
        return result;
      }
    }
    return const FormValidationResult.success();
  }
}