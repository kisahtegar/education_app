import 'package:equatable/equatable.dart';

/// The `Course` class represents a course entity with various properties.
class Course extends Equatable {
  /// Creates a `Course` instance with the provided parameters.
  const Course({
    required this.id,
    required this.title,
    required this.numberOfExams,
    required this.numberOfMaterials,
    required this.numberOfVideos,
    required this.groupId,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.image,
    this.imageIsFile = false,
  });

  /// Creates an empty `Course` instance with default values.
  ///
  /// This constructor can be used for creating a placeholder or default course
  /// model with empty or default values for various properties.
  Course.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          description: '_empty.description',
          numberOfExams: 0,
          numberOfMaterials: 0,
          numberOfVideos: 0,
          groupId: '_empty.groupId',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

  final String id;
  final String title;
  final String? description;
  final int numberOfExams;
  final int numberOfMaterials;
  final int numberOfVideos;
  final String groupId;
  final String? image;
  final bool imageIsFile;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [id];
}
