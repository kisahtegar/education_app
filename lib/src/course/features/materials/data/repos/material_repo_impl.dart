// ignore_for_file: lines_longer_than_80_chars

import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/materials/data/datasources/material_remote_data_src.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource.dart';
import 'package:education_app/src/course/features/materials/domain/repos/material_repo.dart';

/// Implementation of the [MaterialRepo] interface responsible for
/// handling material-related operations.
class MaterialRepoImpl implements MaterialRepo {
  /// Constructs a [MaterialRepoImpl] instance with the provided
  /// [MaterialRemoteDataSrc].
  const MaterialRepoImpl(this._remoteDataSource);

  final MaterialRemoteDataSrc _remoteDataSource;

  /// Retrieves a list of materials associated with a specified course.
  ///
  /// Returns a [ResultFuture] containing a list of [Resource] instances on
  /// success, or a [Left] containing a [ServerFailure] on failure.
  @override
  ResultFuture<List<Resource>> getMaterials(String courseId) async {
    try {
      final result = await _remoteDataSource.getMaterials(courseId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  /// Adds a new material to the remote data source.
  ///
  /// Takes a [Resource] instance as input and returns a [ResultFuture] indicating
  /// the success or failure of the operation. Returns [Right] with `null` on success,
  /// or a [Left] containing a [ServerFailure] on failure.
  @override
  ResultFuture<void> addMaterial(Resource material) async {
    try {
      await _remoteDataSource.addMaterial(material);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
