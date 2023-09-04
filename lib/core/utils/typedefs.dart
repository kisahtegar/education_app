import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';

/// A custom type definition for representing asynchronous operations that
/// return results wrapped in an `Either` monad with a `Failure` on the left
/// side and a value of type [T] on the right side.
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// A custom type definition for representing data as key-value pairs, where the
/// keys are strings and the values are of dynamic type. This type is commonly
/// used for handling data maps, configurations, or JSON-like structures.
typedef DataMap = Map<String, dynamic>;
