enum CustomExceptionType {
  // Major exceptions
  NetworkException,
  ServerException,
  UnknownException,

  // Transaction exceptions
  UnknownTransactionTypeException,
}

class CustomException implements Exception {
  final String message;
  final String prefix;
  final CustomExceptionType type;
  final String? error;

  CustomException(this.message, this.prefix, this.type, this.error);

  @override
  String toString() {
    return "$prefix: $message: $type : $error";
  }
}
