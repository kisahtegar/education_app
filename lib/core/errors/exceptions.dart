import 'package:equatable/equatable.dart';

/// These exceptions are designed for handling errors or exceptional conditions
/// in a more structured and meaningful way than using general-purpose
/// exceptions.
class ServerException extends Equatable implements Exception {
  /// Creates a [ServerException] with the provided [message] and [statusCode].
  const ServerException({
    required this.message,
    required this.statusCode,
  });

  /// The error message describing the exception.
  final String message;

  /// The HTTP status code associated with the exception.
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// These exceptions are designed for handling errors or exceptional conditions
/// in a more structured and meaningful way than using general-purpose
/// exceptions.
class CacheException extends Equatable implements Exception {
  /// Creates a [CacheException] with the provided [message] and optional
  /// [statusCode]. If [statusCode] is not provided, it defaults to 500.
  const CacheException({
    required this.message,
    this.statusCode = 500,
  });

  /// The error message describing the exception.
  final String message;

  /// The HTTP status code associated with the exception.
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}
