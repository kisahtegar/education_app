import 'package:education_app/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A utility class for handling data source-related operations.
class DataSourceUtils {
  const DataSourceUtils._();

  /// Authorizes the user with the provided [auth] instance.
  ///
  /// This function checks if a user is currently authenticated using [auth].
  /// If the user is not authenticated, it throws a [ServerException].
  ///
  /// Throws a [ServerException] with a message 'User is not authenticated'
  /// and a status code '401' if the user is not authenticated.
  ///
  /// [auth]: The [FirebaseAuth] instance used for user authentication.
  static Future<void> authorizeUser(FirebaseAuth auth) async {
    final user = auth.currentUser;
    if (user == null) {
      throw const ServerException(
        message: 'User is not authenticated',
        statusCode: '401',
      );
    }
  }
}
