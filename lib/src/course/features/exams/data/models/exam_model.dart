// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/data/models/exam_question_model.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_question.dart';

/// A concrete implementation of the [Exam] entity that represents an exam
/// within the application. It extends the base [Exam] class to provide
/// specific functionality and data transformation methods.
class ExamModel extends Exam {
  /// Constructs an [ExamModel] instance with the specified parameters.
  const ExamModel({
    required super.id,
    required super.courseId,
    required super.title,
    required super.description,
    required super.timeLimit,
    super.imageUrl,
    super.questions,
  });

  /// Factory method to create an [ExamModel] from a JSON-encoded string.
  factory ExamModel.fromJson(String source) =>
      ExamModel.fromUploadMap(jsonDecode(source) as DataMap);

  /// Creates an empty [ExamModel] instance.
  const ExamModel.empty()
      : this(
          id: 'Test String',
          courseId: 'Test String',
          title: 'Test String',
          description: 'Test String',
          timeLimit: 0,
          questions: const [],
        );

  /// Constructs an [ExamModel] from a map of data.
  ExamModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          courseId: map['courseId'] as String,
          title: map['title'] as String,
          description: map['description'] as String,
          timeLimit: (map['timeLimit'] as num).toInt(),
          imageUrl: map['imageUrl'] as String?,
          questions: null,
        );

  /// Constructs an [ExamModel] from a map of data received during upload.
  ExamModel.fromUploadMap(DataMap map)
      : this(
          id: map['id'] as String? ?? '',
          courseId: map['courseId'] as String? ?? '',
          title: map['title'] as String,
          description: map['Description'] as String,
          timeLimit: (map['time_seconds'] as num).toInt(),
          imageUrl: (map['image_url'] as String).isEmpty
              ? null
              : map['image_url'] as String,
          questions: List<DataMap>.from(map['questions'] as List<dynamic>)
              .map(ExamQuestionModel.fromUploadMap)
              .toList(),
        );

  /// Creates a copy of this [ExamModel] with optional attribute values changed.
  ExamModel copyWith({
    String? id,
    String? courseId,
    List<ExamQuestion>? questions,
    String? title,
    String? description,
    int? timeLimit,
    String? imageUrl,
  }) {
    return ExamModel(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      questions: questions ?? this.questions,
      title: title ?? this.title,
      description: description ?? this.description,
      timeLimit: timeLimit ?? this.timeLimit,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  /// Converts this [ExamModel] instance into a map of data for storage or
  /// serialization.
  ///
  /// We never actually upload the questions with the exam, so we don't need to
  /// convert them to a map. Instead we will keep them in individual
  /// documents, and at the point of taking the exam, we will fetch the questions
  DataMap toMap() {
    return <String, dynamic>{
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'timeLimit': timeLimit,
      'imageUrl': imageUrl,
    };
  }
}
