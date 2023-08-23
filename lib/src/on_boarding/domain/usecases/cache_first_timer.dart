import '../../../../core/usecases/usecases.dart';
import '../../../../core/utils/typedefs.dart';
import '../repository/on_boarding_repository.dart';

class CacheFirstTimer extends UsecaseWithoutParams<void> {
  const CacheFirstTimer(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFuture<void> call() async => _repository.cacheFirstTimer();
}
