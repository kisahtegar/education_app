import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource.dart';
import 'package:education_app/src/course/features/materials/domain/repos/material_repo.dart';

/// A use case responsible for retrieving a list of materials associated with a
/// course.
///
/// This use case extends [FutureUsecaseWithParams] and takes a [String] parameter as
/// input, representing the unique identifier of the course for which materials
/// should be retrieved. It interacts with the [MaterialRepo] to fetch the
/// materials.
class GetMaterials extends FutureUsecaseWithParams<List<Resource>, String> {
  /// Constructs a [GetMaterials] instance with the provided [MaterialRepo].
  const GetMaterials(this._repo);

  final MaterialRepo _repo;

  /// Executes the use case by fetching the list of materials associated with
  /// the specified course.
  ///
  /// Returns a [ResultFuture] containing a list of [Resource] instances on
  /// success.
  @override
  ResultFuture<List<Resource>> call(String params) =>
      _repo.getMaterials(params);
}
