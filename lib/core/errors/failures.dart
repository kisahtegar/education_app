import 'package:education_app/core/errors/exceptions.dart';
import 'package:equatable/equatable.dart';

/// The `Failure` class is an abstract class that serves as a base class for
/// representing failures or errors that can occur within your application. It
/// provides a structured way to handle and manage different types of failures
/// and includes properties and methods to help in error reporting and handling.
abstract class Failure extends Equatable {
  Failure({
    required this.message,
    required this.statusCode,
  }) : assert(
          statusCode.runtimeType == int || statusCode.runtimeType == String,
          'StatusCode cannot be a ${statusCode.runtimeType}',
        );

  final String message;
  final dynamic statusCode;

  /// The class defines a getter method called `errorMessage`, which generates
  /// a formatted error message by combining the `statusCode` and `message`.
  /// If the `statusCode` is of type String, it doesn't append `"Error"` to it;
  /// otherwise, it appends "Error" to indicate an error condition.
  String get errorMessage =>
      '$statusCode${statusCode is String ? '' : '  Error'}: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

/// This class provides a structured way to handle and report errors that occur
/// specifically during cache-related operations.
class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}

/// This class provides a structured way to handle and report errors that occur
/// specifically during interactions with a server, such as making HTTP requests
class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});

  /// This constructor is used to create a `ServerFailure` instance based on a
  /// `ServerException`. It extracts the `message` and `statusCode` properties
  /// from the `ServerException` and uses them to initialize `ServerFailure`
  /// instance.
  ///
  /// This can be helpful when you want to convert specific server exceptions
  /// into application-specific failure types.
  ServerFailure.fromException(ServerException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}
