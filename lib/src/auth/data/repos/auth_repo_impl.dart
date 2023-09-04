// ignore_for_file: lines_longer_than_80_chars

import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';

/// `AuthRepoImpl` bridges the gap between the application's domain layer
/// (containing use cases and business logic) and the remote data source (Firebase
/// in this case). It handles exceptions from the remote data source and wraps
/// results in `Either` values, simplifying success and failure management during
/// authentication operations.
class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  /// Initiates the password reset process for a user by calling `_remoteDataSource.forgotPassword`.
  ///
  /// - [email] - The user's email address.
  @override
  ResultFuture<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  /// Performs user sign-in by calling `_remoteDataSource.signIn`.
  ///
  /// - [email] - The user's email address.
  /// - [password] - The user's password.
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

  /// Handles user registration (sign-up) by calling `_remoteDataSource.signUp`.
  ///
  /// - [email] - The user's email address.
  /// - [fullName] - The user's full name.
  /// - [password] - The user's password.
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

  /// Updates user information such as email, display name, bio, profile picture,
  /// or password by calling `_remoteDataSource.updateUser`.
  ///
  /// - [action] - The action to perform (`UpdateUserAction`).
  /// - [userData] - User data to update.
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
