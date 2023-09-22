// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/repos/notification_repo.dart';

/// A use case that clears a specific notification by its ID.
class Clear extends FutureUsecaseWithParams<void, String> {
  /// Constructs a [Clear] use case with the provided [_repo].
  ///
  /// [_repo] is the notification repository responsible for clearing notifications.
  const Clear(this._repo);

  final NotificationRepo _repo;

  /// Executes the use case to clear a specific notification identified by [params].
  ///
  /// - [params]: The ID of the notification to be cleared.
  ///
  /// Returns a [ResultFuture] indicating the success or failure of the operation.
  @override
  ResultFuture<void> call(String params) => _repo.clear(params);
}
