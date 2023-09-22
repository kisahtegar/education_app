// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';
import 'package:education_app/src/notifications/domain/repos/notification_repo.dart';

/// A use case that retrieves a list of notifications.
class GetNotifications extends StreamUsecaseWithoutParams<List<Notification>> {
  /// Constructs a [GetNotifications] use case with the provided [_repo].
  ///
  /// [_repo] is the notification repository responsible for fetching notifications.
  const GetNotifications(this._repo);

  final NotificationRepo _repo;

  /// Executes the use case to retrieve a list of notifications.
  ///
  /// Returns a [ResultStream] containing a stream of notifications.
  @override
  ResultStream<List<Notification>> call() => _repo.getNotifications();
}
