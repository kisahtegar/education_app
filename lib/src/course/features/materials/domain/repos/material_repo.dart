// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource.dart';

/// The `MaterialRepo` abstract class defines the contract for repositories
/// that provide access to educational materials within a course.
///
/// Repositories implementing this interface are responsible for fetching and
/// managing materials associated with specific courses.
abstract class MaterialRepo {
  /// Creates an instance of `MaterialRepo`.
  const MaterialRepo();

  /// Retrieves a list of educational materials for a specific course.
  ///
  /// - [courseId]: The identifier of the course for which materials are requested.
  /// Returns a `ResultFuture` containing either a list of `Resource` objects on
  /// success or a `Failure` on failure.
  ResultFuture<List<Resource>> getMaterials(String courseId);

  /// Adds a new educational material to a course.
  ///
  /// - [material]: The `Resource` object representing the material to be added.
  /// Returns a `ResultFuture` indicating success or failure.
  ResultFuture<void> addMaterial(Resource material);
}
