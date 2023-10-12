// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/utils/typedefs.dart';

/// These abstract classes provide a structured way to define and implement use
/// cases in your application, following the Clean Architecture pattern.
/// Use cases encapsulate the business logic and domain-specific operations of
/// your application, and by defining these abstract classes, you establish a
/// clear contract for use case implementations throughout your codebase.
///
/// This approach enhances code maintainability and testability, as concrete use
/// cases can be created by extending these abstract classes and providing
/// specific implementations for the `call` method, tailored to your application's
/// requirements.
///
/// ## Example:
/// ```dart
/// class GetUserData extends FutureUsecaseWithParams<User, String> {
///   final UserRepository repository;
///
///   GetUserData(this.repository);
///
///   @override
///   ResultFuture<User> call(String userId) {
///     return repository.getUserById(userId);
///   }
/// }
/// ```
abstract class FutureUsecaseWithParams<Type, Params> {
  const FutureUsecaseWithParams();

  /// Executes the use case with the provided parameters.
  ///
  /// Returns a [ResultFuture] containing the result of the use case execution.
  ResultFuture<Type> call(Params params);
}

/// These abstract classes provide a structured way to define and implement use
/// cases in your application, following the Clean Architecture pattern.
/// Use cases encapsulate the business logic and domain-specific operations of
/// your application, and by defining these abstract classes, you establish a
/// clear contract for use case implementations throughout your codebase.
///
/// This approach enhances code maintainability and testability, as concrete use
/// cases can be created by extending these abstract classes and providing
/// specific implementations for the `call` method, tailored to your application's
/// requirements.
///
/// ## Example:
/// ```dart
/// class GetUserData extends FutureUsecaseWithoutParams<User> {
///   final UserRepository repository;
///
///   GetUserData(this.repository);
///
///   @override
///   ResultFuture<User> call() {
///     return repository.getCurrentUser();
///   }
/// }
/// ```
abstract class FutureUsecaseWithoutParams<Type> {
  const FutureUsecaseWithoutParams();

  /// Executes the use case without requiring any parameters.
  ///
  /// Returns a [ResultFuture] containing the result of the use case execution.
  ResultFuture<Type> call();
}

/// These abstract classes provide a structured way to define and implement use
/// cases in your application, following the Clean Architecture pattern.
/// Use cases encapsulate the business logic and domain-specific operations of
/// your application, and by defining these abstract classes, you establish a
/// clear contract for use case implementations throughout your codebase.
///
/// This approach enhances code maintainability and testability, as concrete use
/// cases can be created by extending these abstract classes and providing
/// specific implementations for the `call` method, tailored to your application's
/// requirements.
///
/// ## Example:
/// ```dart
/// class GetLiveUpdates extends StreamUsecaseWithoutParams<List<Update>> {
///   final UpdateRepository repository;
///
///   GetLiveUpdates(this.repository);
///
///   @override
///   ResultStream<List<Update>> call() {
///     return repository.getLiveUpdates();
///   }
/// }
/// ```
abstract class StreamUsecaseWithoutParams<Type> {
  const StreamUsecaseWithoutParams();

  /// Executes the use case without requiring any parameters.
  ///
  /// Returns a [ResultStream] containing the stream of results from the use case.
  ResultStream<Type> call();
}

/// These abstract classes provide a structured way to define and implement use
/// cases in your application, following the Clean Architecture pattern.
/// Use cases encapsulate the business logic and domain-specific operations of
/// your application, and by defining these abstract classes, you establish a
/// clear contract for use case implementations throughout your codebase.
///
/// This approach enhances code maintainability and testability, as concrete use
/// cases can be created by extending these abstract classes and providing
/// specific implementations for the `call` method, tailored to your application's
/// requirements.
///
/// ## Example:
/// ```dart
/// class GetLiveUpdates extends StreamUsecaseWithParams<List<Update>, Params> {
///   final UpdateRepository repository;
///
///   GetLiveUpdates(this.repository);
///
///   @override
///   ResultStream<List<Update>> call(Params params) {
///     return repository.getLiveUpdates(params);
///   }
/// ```
abstract class StreamUsecaseWithParams<Type, Params> {
  const StreamUsecaseWithParams();

  /// Executes the use case with the provided parameters.
  ///
  /// Returns a [ResultStream] containing the stream of results from the use case.
  ResultStream<Type> call(Params params);
}
