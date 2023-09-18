// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource.dart';

/// The `ResourceModel` class is an implementation of the `Resource` entity.
///
/// It represents a resource within an educational course and provides methods
/// for creating, copying, and converting resource data to a `DataMap`.
class ResourceModel extends Resource {
  /// Creates a `ResourceModel` instance with the provided details.
  ///
  /// - [id]: The unique identifier for the resource.
  /// - [courseId]: The identifier of the course to which the resource belongs.
  /// - [uploadDate]: The date when the resource was uploaded.
  /// - [fileURL]: The URL or file path where the resource is located.
  /// - [fileExtension]: The file extension of the resource.
  /// - [isFile]: A flag indicating whether the resource is a file.
  /// - [title]: An optional title for the resource.
  /// - [author]: The author or creator of the resource.
  /// - [description]: An optional description of the resource.
  const ResourceModel({
    required super.id,
    required super.courseId,
    required super.uploadDate,
    required super.fileURL,
    required super.fileExtension,
    required super.isFile,
    super.title,
    super.author,
    super.description,
  });

  /// Creates an empty `ResourceModel` instance with default values.
  ///
  /// This constructor is often used as a placeholder or to initialize an
  /// empty `ResourceModel` object.
  ResourceModel.empty([DateTime? date])
      : this(
          id: '_empty.id',
          title: '_empty.title',
          description: '_empty.description',
          uploadDate: date ?? DateTime.now(),
          fileExtension: '_empty.fileExtension',
          isFile: true,
          courseId: '_empty.courseId',
          fileURL: '_empty.fileURL',
          author: '_empty.author',
        );

  /// Creates a `ResourceModel` instance from a `DataMap`.
  ///
  /// This constructor is used to convert a `DataMap` (typically obtained from
  /// a database or API) into a `ResourceModel` object.
  ResourceModel.fromMap(DataMap map)
      : super(
          id: map['id'] as String,
          title: map['title'] as String?,
          description: map['description'] as String?,
          uploadDate: (map['uploadDate'] as Timestamp).toDate(),
          fileExtension: map['fileExtension'] as String,
          isFile: map['isFile'] as bool,
          courseId: map['courseId'] as String,
          fileURL: map['fileURL'] as String,
          author: map['author'] as String?,
        );

  /// Creates a copy of this [ResourceModel] with updated properties.
  ///
  /// This method is useful for making modifications to an existing resource object.
  ResourceModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? uploadDate,
    String? fileExtension,
    bool? isFile,
    String? courseId,
    String? fileURL,
    String? author,
  }) {
    return ResourceModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      uploadDate: uploadDate ?? this.uploadDate,
      courseId: courseId ?? this.courseId,
      fileURL: fileURL ?? this.fileURL,
      isFile: isFile ?? this.isFile,
      author: author ?? this.author,
      fileExtension: fileExtension ?? this.fileExtension,
    );
  }

  /// Converts this [ResourceModel] instance to a map for storage or serialization.
  ///
  /// The resulting map can be easily converted back to a [ResourceModel] using
  /// the [ResourceModel.fromMap] constructor.
  DataMap toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'uploadDate': FieldValue.serverTimestamp(),
      'courseId': courseId,
      'fileURL': fileURL,
      'author': author,
      'isFile': isFile,
      'fileExtension': fileExtension,
    };
  }
}
