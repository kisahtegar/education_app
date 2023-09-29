// ignore_for_file: lines_longer_than_80_chars

import 'package:equatable/equatable.dart';

/// The `PickedResource` class represents a resource that has been picked by a user.
///
/// This class is used to store information about the picked resource, including
/// its path, author, title, description, and whether the author was manually set.
/// It extends the `Equatable` class for easy comparison and equality checks.
class PickedResource extends Equatable {
  /// Creates a `PickedResource` with the specified parameters.
  ///
  /// - The [path] parameter represents the path to the resource.
  /// - The [title] parameter represents the title of the resource.
  /// - The [author] parameter represents the author of the resource.
  /// - The [description] parameter (optional) provides a description of the resource.
  /// - The [authorManuallySet] parameter (optional) indicates whether the author was manually set.
  const PickedResource({
    required this.path,
    required this.author,
    required this.title,
    this.authorManuallySet = false,
    this.description = '',
  });

  /// Creates a copy of the current `PickedResource` with optional parameter changes.
  ///
  /// Returns a new `PickedResource` instance with the same properties as the
  /// current instance, except for the properties specified in the optional parameters.
  PickedResource copyWith({
    String? path,
    String? title,
    String? author,
    String? description,
    bool? authorManuallySet,
  }) {
    return PickedResource(
      path: path ?? this.path,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      authorManuallySet: authorManuallySet ?? this.authorManuallySet,
    );
  }

  /// The path to the picked resource.
  final String path;

  /// The title of the picked resource.
  final String title;

  /// The author of the picked resource.
  final String author;

  /// A description of the picked resource (optional).
  final String description;

  /// Indicates whether the author of the resource was manually set.
  final bool authorManuallySet;

  @override
  List<Object?> get props => [path];
}
