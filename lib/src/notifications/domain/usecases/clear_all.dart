// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/repos/notification_repo.dart';

/// A use case that clears all notifications.
class ClearAll extends FutureUsecaseWithoutParams<void> {
  /// Constructs a [ClearAll] use case with the provided [_repo].
  ///
  /// [_repo] is the notification repository responsible for clearing notifications.
  const ClearAll(this._repo);

  final NotificationRepo _repo;

  /// Executes the use case to clear all notifications.
  ///
  /// Returns a [ResultFuture] indicating the success or failure of the operation.
  @override
  ResultFuture<void> call() => _repo.clearAll();
}
