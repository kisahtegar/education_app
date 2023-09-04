// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/res/media_res.dart';
import 'package:equatable/equatable.dart';

/// `PageContent` is a data model class that simplifies the management of
/// onboarding page content by providing a structured way to define and access
/// the data for each page. It promotes code readability and maintainability
/// when building onboarding screens in an app.
class PageContent extends Equatable {
  /// Creates a new `PageContent` instance with the specified content.
  ///
  /// The [image], [title], and [description] must not be null.
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  // These are named constructors that provide pre-defined `PageContent` instances
  // for the first, second, and third onboarding pages. Each of these constructors
  // sets specific values for image, title, and description based on the
  // corresponding onboarding page.

  /// Creates a `PageContent` instance for the first onboarding page.
  const PageContent.first()
      : this(
          image: MediaRes.casualReading,
          title: 'Brand new curriculum',
          description:
              'This is the first online education platform designed by the '
              "world's top professors",
        );

  /// Creates a `PageContent` instance for the second onboarding page.
  const PageContent.second()
      : this(
          image: MediaRes.casualLife,
          title: 'Brand a fun atmosphere',
          description:
              'This is the first online education platform designed by the '
              "world's top professors",
        );

  /// Creates a `PageContent` instance for the third onboarding page.
  const PageContent.third()
      : this(
          image: MediaRes.casualMeditationScience,
          title: 'Easy to join the lesson',
          description:
              'This is the first online education platform designed by the '
              "world's top professors",
        );

  /// The image associated with this page content.
  final String image;

  /// The title of this page content.
  final String title;

  /// The description of this page content.
  final String description;

  /// A list of properties that specifies which properties should be considered when
  /// determining if two `PageContent` instances are equal. In this case, the
  /// `props` list includes `image`, `title`, and `description`.
  @override
  List<Object?> get props => [image, title, description];
}
