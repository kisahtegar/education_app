import 'package:education_app/core/utils/typedefs.dart';

// These abstract classes provide a structured way to define and implement use
// cases in your application. Use cases are an important part of the Clean
// Architecture pattern, as they encapsulate the business logic and domain -
// specific operations of your application. By defining these abstract classes,
// you create a clear contract for use case implementations throughout your
// codebase, making it easier to reason about and test your application's
// behavior. Concrete use cases can be created by extending these abstract
// classes and providing specific implementations for the call method, tailored
// to your application's requirements.

abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  ResultFuture<Type> call();
}
