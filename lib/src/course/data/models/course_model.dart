// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/domain/entities/course.dart';

/// The `CourseModel` class extends the `Course` entity and represents a
/// course with additional functionality for data manipulation. It is designed
/// to work with data retrieved from a data source, such as a database.
class CourseModel extends Course {
  /// Creates a `CourseModel` instance with the provided parameters. This constructor
  /// extends the base `Course` class, inheriting its properties and behavior.
  const CourseModel({
    required super.id,
    required super.title,
    required super.numberOfExams,
    required super.numberOfMaterials,
    required super.numberOfVideos,
    required super.groupId,
    required super.createdAt,
    required super.updatedAt,
    super.description,
    super.image,
    super.imageIsFile,
  });

  /// Creates an empty `CourseModel` instance with default values. This constructor
  /// extends the base `Course` class, inheriting its properties and behavior.
  CourseModel.empty()
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

  /// Creates a `CourseModel` instance from a `Map` representation of the data.
  /// This constructor extends the base `Course` class, inheriting its properties
  /// and behavior. It's useful for converting data retrieved from a database or
  /// other sources into a `CourseModel`.
  CourseModel.fromMap(DataMap map)
      : super(
          id: map['id'] as String,
          title: map['title'] as String,
          numberOfExams: (map['numberOfExams'] as num).toInt(),
          numberOfMaterials: (map['numberOfMaterials'] as num).toInt(),
          numberOfVideos: (map['numberOfVideos'] as num).toInt(),
          groupId: map['groupId'] as String,
          createdAt: (map['createdAt'] as Timestamp).toDate(),
          updatedAt: (map['updatedAt'] as Timestamp).toDate(),
          description: map['description'] as String?,
          image: map['image'] as String?,
        );

  /// Creates a copy of this `CourseModel` instance with optional property changes.
  /// This method allows for creating a new `CourseModel` instance while preserving
  /// the original data where no changes are specified.
  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    int? numberOfExams,
    int? numberOfMaterials,
    int? numberOfVideos,
    String? groupId,
    String? image,
    bool? imageIsFile,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      numberOfExams: numberOfExams ?? this.numberOfExams,
      numberOfMaterials: numberOfMaterials ?? this.numberOfMaterials,
      numberOfVideos: numberOfVideos ?? this.numberOfVideos,
      groupId: groupId ?? this.groupId,
      image: image ?? this.image,
      imageIsFile: imageIsFile ?? this.imageIsFile,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Converts this `CourseModel` instance to a `Map` representation of the data.
  /// This method is useful for preparing the object for storage in a database or
  /// for serialization when sending data to external services.
  DataMap toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'numberOfExams': numberOfExams,
      'numberOfMaterials': numberOfMaterials,
      'numberOfVideos': numberOfVideos,
      'groupId': groupId,
      'image': image,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
