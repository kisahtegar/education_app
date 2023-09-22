// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/repos/notification_repo.dart';

/// A use case that marks a notification as read.
class MarkAsRead extends FutureUsecaseWithParams<void, String> {
  /// Constructs a [MarkAsRead] use case with the provided [_repo].
  ///
  /// [_repo] is the notification repository responsible for marking notifications as read.
  const MarkAsRead(this._repo);

  final NotificationRepo _repo;

  /// Executes the use case to mark a notification as read.
  ///
  /// [params] is the unique identifier of the notification to mark as read.
  ///
  /// Returns a [ResultFuture] indicating the success or failure of the operation.
  @override
  ResultFuture<void> call(String params) => _repo.markAsRead(params);
}
