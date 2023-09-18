// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource.dart';
import 'package:education_app/src/course/features/materials/domain/usecases/add_material.dart';
import 'package:education_app/src/course/features/materials/domain/usecases/get_materials.dart';
import 'package:equatable/equatable.dart';

part 'material_state.dart';

/// Cubit responsible for managing state related to course materials.
class MaterialCubit extends Cubit<MaterialState> {
  MaterialCubit({
    required AddMaterial addMaterial,
    required GetMaterials getMaterials,
  })  : _addMaterial = addMaterial,
        _getMaterials = getMaterials,
        super(const MaterialInitial());

  final AddMaterial _addMaterial;
  final GetMaterials _getMaterials;

  /// Adds a list of materials to the course.
  /// Emits states to reflect the progress and outcome of the operation.
  ///
  /// - `materials`: The list of [Resource] entities to be added.
  Future<void> addMaterials(List<Resource> materials) async {
    emit(const AddingMaterials());

    for (final material in materials) {
      final result = await _addMaterial(material);
      result.fold(
        (failure) {
          emit(MaterialError(failure.errorMessage));
          return;
        },
        (_) => null,
      );
    }
    if (state is! MaterialError) emit(const MaterialsAdded());
  }

  /// Retrieves materials for a specified course.
  /// Emits states to reflect the progress and outcome of the operation.
  ///
  /// - `courseId`: The identifier of the course for which materials are requested.
  Future<void> getMaterials(String courseId) async {
    emit(const LoadingMaterials());
    final result = await _getMaterials(courseId);
    result.fold(
      (failure) => emit(MaterialError(failure.errorMessage)),
      (materials) => emit(MaterialsLoaded(materials)),
    );
  }
}
