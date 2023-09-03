import 'package:equatable/equatable.dart';

/// These exceptions typically used to handle errors or exceptional conditions
/// in a more structured and meaningful way than using general-purpose
/// exceptions.
class ServerException extends Equatable implements Exception {
  const ServerException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// These exceptions typically used to handle errors or exceptional conditions
/// in a more structured and meaningful way than using general-purpose
/// exceptions.
class CacheException extends Equatable implements Exception {
  const CacheException({
    required this.message,
    this.statusCode = 500,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}
