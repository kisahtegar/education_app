import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource.dart';
import 'package:education_app/src/course/features/materials/domain/repos/material_repo.dart';

/// A use case responsible for adding a new material to the course materials.
///
/// This use case extends [FutureUsecaseWithParams] and takes a [Resource]
/// instance as input, representing the material to be added. It interacts with
/// the [MaterialRepo] to perform the addition operation.
class AddMaterial extends FutureUsecaseWithParams<void, Resource> {
  /// Constructs an [AddMaterial] instance with the provided [MaterialRepo].
  const AddMaterial(this._repo);

  final MaterialRepo _repo;

  /// Executes the use case by adding the specified [Resource] material.
  ///
  /// Returns a [ResultFuture] indicating the success or failure of the
  /// operation.
  @override
  ResultFuture<void> call(Resource params) => _repo.addMaterial(params);
}
