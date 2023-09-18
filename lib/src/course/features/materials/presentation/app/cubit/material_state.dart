part of 'material_cubit.dart';

/// Represents the different states for the MaterialCubit.
sealed class MaterialState extends Equatable {
  const MaterialState();
  @override
  List<Object> get props => [];
}

/// Initial state when no materials are loaded.
final class MaterialInitial extends MaterialState {
  const MaterialInitial();
}

/// State indicating that materials are being added to the course.
final class AddingMaterials extends MaterialState {
  const AddingMaterials();
}

/// State indicating that materials are being loaded.
final class LoadingMaterials extends MaterialState {
  const LoadingMaterials();
}

/// State indicating that materials have been successfully added.
final class MaterialsAdded extends MaterialState {
  const MaterialsAdded();
}

/// State indicating that materials have been loaded successfully.
final class MaterialsLoaded extends MaterialState {
  const MaterialsLoaded(this.materials);

  final List<Resource> materials;

  @override
  List<Object> get props => [materials];
}

/// State representing an error condition with an associated error message.
final class MaterialError extends MaterialState {
  const MaterialError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
