// ignore_for_file: lines_longer_than_80_chars

import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/data/datasources/course_remote_data_src.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/domain/repos/course_repo.dart';

/// `CourseRepoImpl` is an implementation of the `CourseRepo` interface that
/// provides concrete functionality for accessing and manipulating course-related
/// data. It interacts with a remote data source to perform operations such as
/// adding courses and retrieving a list of courses. It uses error handling to
/// manage exceptions and returns results wrapped in `Either` to indicate success
/// or failure in a functional and predictable manner.
class CourseRepoImpl implements CourseRepo {
  /// Creates a `CourseRepoImpl` instance with the provided remote data source.
  const CourseRepoImpl(this._remoteDataSrc);

  final CourseRemoteDataSrc _remoteDataSrc;

  /// Adds a course to the remote data source.
  ///
  /// Returns [Right] on success or [Left] with a [ServerFailure] on failure.
  @override
  ResultFuture<void> addCourse(Course course) async {
    try {
      await _remoteDataSrc.addCourse(course);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  /// Retrieves a list of courses from the remote data source.
  ///
  /// Returns [Right] with the list of courses on success or [Left] with a
  /// [ServerFailure] on failure.
  @override
  ResultFuture<List<Course>> getCourses() async {
    try {
      final courses = await _remoteDataSrc.getCourses();
      return Right(courses);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
