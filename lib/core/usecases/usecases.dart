import 'package:education_app/core/utils/typedefs.dart';

/// These abstract classes provide a structured way to define and implement use
/// cases in your application. Use cases encapsulate the business logic and
/// domain-specific operations of your application, following the Clean
/// Architecture pattern. By defining these abstract classes, you establish a
/// clear contract for use case implementations across your codebase. This
/// approach enhances code maintainability and testability. Concrete use cases
/// can be created by extending these abstract classes and providing specific
/// implementations for the `call` method, tailored to your application's
/// requirements.

abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();

  /// Executes the use case with the provided parameters.
  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  /// Executes the use case without requiring any parameters.
  ResultFuture<Type> call();
}
