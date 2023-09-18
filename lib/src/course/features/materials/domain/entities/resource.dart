// ignore_for_file: lines_longer_than_80_chars

import 'package:equatable/equatable.dart';

/// The `Resource` class represents a resource within an educational course.
///
/// A resource can be various types of content such as documents, videos, or
/// other educational materials. It includes details such as its unique
/// identifier (id), the identifier of the course to which it belongs (courseId),
/// the date it was uploaded (uploadDate), the URL or file path where the resource
/// is located (fileURL), a flag indicating whether the resource is a file (isFile),
/// the file extension (fileExtension), an optional title for the resource (title),
/// the author or creator of the resource (author), and an optional description.
class Resource extends Equatable {
  /// Creates a `Resource` instance with the provided details.
  ///
  /// - [id]: The unique identifier for the resource.
  /// - [courseId]: The identifier of the course to which the resource belongs.
  /// - [uploadDate]: The date when the resource was uploaded.
  /// - [fileURL]: The URL or file path where the resource is located.
  /// - [isFile]: A flag indicating whether the resource is a file.
  /// - [fileExtension]: The file extension of the resource.
  /// - [title]: An optional title for the resource.
  /// - [author]: The author or creator of the resource.
  /// - [description]: An optional description of the resource.
  const Resource({
    required this.id,
    required this.courseId,
    required this.uploadDate,
    required this.fileURL,
    required this.isFile,
    required this.fileExtension,
    this.title,
    this.author,
    this.description,
  });

  /// Creates an empty `Resource` instance with default values.
  ///
  /// This constructor is often used as a placeholder or to initialize an
  /// empty `Resource` object.
  Resource.empty([DateTime? date])
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

  /// The unique identifier for the resource.
  final String id;

  /// The identifier of the course to which the resource belongs.
  final String courseId;

  /// The date when the resource was uploaded.
  final DateTime uploadDate;

  /// The URL or file path where the resource is located.
  final String fileURL;

  /// A flag indicating whether the resource is a file.
  final bool isFile;

  /// The file extension of the resource.
  final String fileExtension;

  /// An optional title for the resource.
  final String? title;

  /// The author or creator of the resource.
  final String? author;

  /// An optional description of the resource.
  final String? description;

  @override
  List<Object?> get props => [id, courseId];
}
