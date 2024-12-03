class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

/// Define specific custom exceptions

class ForbiddenException extends ApiException {
  ForbiddenException([super.message = 'Forbidden']);
}

class NotFoundException extends ApiException {
  NotFoundException([super.message = 'Not Found']);
}

class ConflictException extends ApiException {
  ConflictException([super.message = 'Conflict']);
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException([super.message = 'Internal Server Error']);
}

class ServiceUnavailableException extends ApiException {
  ServiceUnavailableException([super.message = 'Service Unavailable']);
}
class MyException extends ApiException {
  MyException([super.message = 'No Internet Available']);
}
