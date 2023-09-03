import 'package:education_app/core/utils/typedefs.dart';

/// `OnBoardingRepository` is an abstract class that defines a contract for
/// accessing and manipulating onboarding-related data in application. It
/// enforces consistency and provides a clear interface for concrete repository
/// implementations to follow. The specific behavior of the methods, error
/// handling, and data sources will be determined by the concrete implementation
/// of this repository.
abstract class OnBoardingRepository {
  const OnBoardingRepository();

  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
