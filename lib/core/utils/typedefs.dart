import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';

/// Represents the result of an asynchronous operation that returns a value of
/// type [T] wrapped in an `Either` monad. The `Either` can have a `Failure` on
/// the left side or a value of type [T] on the right side.
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// Represents the result of an asynchronous operation that returns a stream of
/// values of type [T] wrapped in an `Either` monad. The `Either` can have a
/// `Failure` on the left side or a value of type [T] on the right side.
typedef ResultStream<T> = Stream<Either<Failure, T>>;

/// Represents a key-value pair data structure where the keys are strings, and
/// the values can be of dynamic types. This type is commonly used for handling
/// data maps, configurations, or JSON-like structures.
typedef DataMap = Map<String, dynamic>;
