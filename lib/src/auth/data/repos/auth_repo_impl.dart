import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';

/// `AuthRepoImpl` acts as a bridge between the application's domain layer
/// (where use cases and business logic reside) and the remote data source
/// (Firebase in this case). It handles exceptions thrown by the remote data
/// source and wraps the results in `Either` values, making it easier for higher
/// - level components to manage success and failure scenarios during
/// authentication operations.
class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  /// This method is responsible for initiating the password reset process for a
  /// user by calling the `forgotPassword` method of the `_remoteDataSource`. It
  /// takes the user's email as a parameter.
  @override
  ResultFuture<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  /// This method is responsible for user sign-in by calling the `signIn` method
  /// of the `_remoteDataSource`. It takes the user's email and password as
  /// parameters.
  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  /// This method is responsible for user registration (sign-up) by calling the
  /// `signUp` method of the `_remoteDataSource`. It takes the user's email,
  /// full name, and password as parameters.
  @override
  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      await _remoteDataSource.signUp(
        email: email,
        fullName: fullName,
        password: password,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  /// This method is used to update user information, such as email, display
  /// name, bio, profile picture, or password. It calls the updateUser method of
  /// the `_remoteDataSource` and takes parameters for the action to perform
  /// (`UpdateUserAction`) and the user data to update.
  @override
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      await _remoteDataSource.updateUser(
        action: action,
        userData: userData,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
