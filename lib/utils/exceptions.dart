class CustomException implements Exception {
  final Map error;
  final String response;
  final String errorCode;

  CustomException({
    required this.error,
    this.errorCode = '',
    this.response = '',
  });

  @override
  String toString() => '$error: $errorCode';
}

class InvalidEmailException extends CustomException {
  InvalidEmailException({Map error = const {'error': 'Invalid email'}})
      : super(error: error);
}

class EmailAlreadyInUseException extends CustomException {
  EmailAlreadyInUseException(
      {Map error = const {'error': 'Email entered is already in use'}})
      : super(error: error);
}

class MissingInfoException extends CustomException {
  MissingInfoException(
      {Map error = const {'error': 'Some information is missing'}})
      : super(
          error: error,
        );
}

class UserNotFound extends CustomException {
  UserNotFound({Map error = const {'error': 'User not found'}})
      : super(error: error);
}

class WrongPasswordException extends CustomException {
  WrongPasswordException({Map error = const {'error': 'User not found'}})
      : super(error: error);
}

class WeakPasswordException extends CustomException {
  WeakPasswordException({Map error = const {'error': 'Weak password'}})
      : super(error: error);
}

class PasswordsNotMatchingException extends CustomException {
  PasswordsNotMatchingException(
      {Map error = const {'error': 'Passwords do not match'}})
      : super(error: error);
}

class StartDateAfterThanDueDate extends CustomException {
  StartDateAfterThanDueDate(
      {Map error = const {'error': 'The start date can be after the due date'}})
      : super(error: error);
}

class UnknownException extends CustomException {
  UnknownException({Map error = const {'error': 'Unknown'}})
      : super(error: error);
}
