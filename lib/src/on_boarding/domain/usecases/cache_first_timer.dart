import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/domain/repository/on_boarding_repository.dart';

/// `CacheFirstTimer` is a use case class responsible for invoking the
/// `cacheFirstTimer` method of the provided `OnBoardingRepository`. It
/// encapsulates the logic of caching a specific piece of data and can be used
/// as part of the app's onboarding process or any other logic that requires
/// caching this information.
class CacheFirstTimer extends UsecaseWithoutParams<void> {
  const CacheFirstTimer(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFuture<void> call() async => _repository.cacheFirstTimer();
}
