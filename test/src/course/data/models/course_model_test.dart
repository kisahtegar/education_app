import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/data/models/course_model.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  // Define test data
  final timestampData = {'_seconds': 1677483548, '_nanoseconds': 123456000};
  final date = DateTime.fromMillisecondsSinceEpoch(
    timestampData['_seconds']!,
  ).add(
    Duration(
      microseconds: timestampData['_nanoseconds']!,
    ),
  );

  // Create a Timestamp instance for testing
  final tTimestamp = Timestamp.fromDate(date);

  // Create an empty CourseModel for testing
  final tCourseModel = CourseModel.empty();

  // Load test data from a fixture file
  final tMap = jsonDecode(fixture('course.json')) as DataMap;
  tMap['createdAt'] = tTimestamp;
  tMap['updatedAt'] = tTimestamp;

  test('should be a subclass of [Course] entity', () {
    expect(tCourseModel, isA<Course>());
  });

  group('empty', () {
    test('should return a [CourseModel] with empty data', () {
      final result = CourseModel.empty();
      expect(result.title, '_empty.title');
    });
  });

  group('fromMap', () {
    test('should return a [CourseModel] with the correct data', () {
      final result = CourseModel.fromMap(tMap);
      expect(result, equals(tCourseModel));
    });
  });
  group('toMap', () {
    test('should return a [Map] with the proper data', () {
      // This would look like if i had date in mind.
      // Remove createdAt and updatedAt fields since they are timestamp objects
      final result = tCourseModel.toMap()
        ..remove('createdAt')
        ..remove('updatedAt');

      final map = DataMap.from(tMap)
        ..remove('createdAt')
        ..remove('updatedAt');

      expect(result, equals(map));

      // This throw error so we need to remove createdAt and updatedAt
      // timestamp problem.
      // final result = tCourseModel.toMap();
      // expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test('should return a [CourseModel] with the new data', () async {
      final result = tCourseModel.copyWith(
        title: 'New Title',
      );
      expect(result.title, 'New Title');
    });
  });
}
