// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';

/// The `AuthRepo` interface defines a set of abstract methods that encapsulate
/// authentication-related functionality required by the application. Concrete
/// classes implementing this interface will provide the actual implementation
/// for these methods, allowing the application to interact with different data
/// sources while adhering to a consistent contract for authentication operations.
abstract class AuthRepo {
  const AuthRepo();

  /// Initiates the password reset process for a user.
  ///
  /// - [email] - The user's email address.
  ResultFuture<void> forgotPassword(String email);

  /// Performs user sign-in.
  ///
  /// - [email] - The user's email address.
  /// - [password] - The user's password.
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  /// Handles user registration (sign-up).
  ///
  /// - [email] - The user's email address.
  /// - [fullName] - The user's full name.
  /// - [password] - The user's password.
  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  /// Updates user information, such as email, display name, bio, profile picture,
  /// or password.
  ///
  /// - [action] - The action to perform (`UpdateUserAction`).
  /// - [userData] - User data to update.
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}
