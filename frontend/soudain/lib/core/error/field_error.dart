class FieldError {
  final String field;
  final String message;

  FieldError({
    this.field,
    this.message
  });

  factory FieldError.fromJson(Map<String, dynamic> jsonMap) {
    return FieldError(
      message: jsonMap['message'],
      field: jsonMap['field']
    );
  }
}