import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/domain/repository/on_boarding_repository.dart';

/// This use case class allows the app to easily check and obtain the status of
/// whether a user is a first-time user or not.
class CheckIfUserIsFirstTimer extends UsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFuture<bool> call() => _repository.checkIfUserIsFirstTimer();
}
