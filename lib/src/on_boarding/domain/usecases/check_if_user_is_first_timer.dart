import '../../../../core/usecases/usecases.dart';
import '../../../../core/utils/typedefs.dart';
import '../repository/on_boarding_repository.dart';

class CheckIfUserIsFirstTimer extends UsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFuture<bool> call() => _repository.checkIfUserIsFirstTimer();
}
