import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../fixtures/fixture_reader.dart';

void main() {
  // Timestamp data used for testing
  final timestampData = {
    '_seconds': 1677483548,
    '_nanoseconds': 123456000,
  };

  // Create a DateTime object from timestamp data
  final date =
      DateTime.fromMillisecondsSinceEpoch(timestampData['_seconds']!).add(
    Duration(microseconds: timestampData['_nanoseconds']!),
  );

  // Create a Timestamp object from the DateTime
  final timestamp = Timestamp.fromDate(date);

  // Create an empty VideoModel instance
  final tVideoModel = VideoModel.empty();

  // Load test data from a fixture JSON file
  final tMap = jsonDecode(fixture('video.json')) as DataMap;

  // Replace the 'uploadDate' field in the test data with the Timestamp
  tMap['uploadDate'] = timestamp;

  test(
    'should be a subclass of [Video] entity',
    () {
      expect(tVideoModel, isA<Video>());
    },
  );

  group(
    'fromMap',
    () {
      test(
        'should return a [VideoModel] with the correct data',
        () {
          final result = VideoModel.fromMap(tMap);
          expect(result, equals(tVideoModel));
        },
      );
    },
  );

  group(
    'toMap',
    () {
      test(
        'should return a [Map] with the proper data',
        () async {
          // Remove the 'uploadDate' field from the result
          final result = tVideoModel.toMap()..remove('uploadDate');

          // Remove the 'uploadDate' field from the test data
          final map = DataMap.from(tMap)..remove('uploadDate');
          expect(result, equals(map));
        },
      );
    },
  );

  group(
    'copyWith',
    () {
      test(
        'should return a [VideoModel] with the new data',
        () async {
          final result = tVideoModel.copyWith(
            tutor: 'New Tutor',
          );

          expect(result.tutor, 'New Tutor');
        },
      );
    },
  );
}
