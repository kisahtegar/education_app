// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/datasource_utils.dart';
import 'package:education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Abstract class representing the remote data source for video-related operations.
abstract class VideoRemoteDataSrc {
  /// Retrieves a list of videos associated with a specified course.
  ///
  /// Returns a [Future] containing a list of [VideoModel] instances on success.
  /// Throws a [ServerException] if any error occurs during the operation.
  Future<List<VideoModel>> getVideos(String courseId);

  /// Adds a new video to the remote data source.
  ///
  /// Takes a [Video] instance as input and returns a [Future] indicating
  /// the success or failure of the operation. Throws a [ServerException] on failure.
  Future<void> addVideo(Video video);
}

/// Implementation of the [VideoRemoteDataSrc] interface responsible for interacting
/// with video-related data from a remote source.
class VideoRemoteDataSrcImpl implements VideoRemoteDataSrc {
  /// Constructs a [VideoRemoteDataSrcImpl] instance with the required dependencies.
  const VideoRemoteDataSrcImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _auth = auth,
        _firestore = firestore,
        _storage = storage;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  /// Adds a new video to the remote data source.
  ///
  /// Takes a [Video] instance as input and returns a [Future] indicating
  /// the success or failure of the operation.
  @override
  Future<void> addVideo(Video video) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_auth);

      // Create a reference to the video document in Firestore.
      final videoRef = _firestore
          .collection('courses')
          .doc(video.courseId)
          .collection('videos')
          .doc();

      // Create a VideoModel instance with a unique ID.
      var videoModel = (video as VideoModel).copyWith(id: videoRef.id);

      // If the video has a thumbnail file, upload it to Firebase Storage.
      if (videoModel.thumbnailIsFile) {
        final thumbnailFileRef = _storage.ref().child(
              'courses/${videoModel.courseId}/videos/${videoRef.id}/thumbnail',
            );
        await thumbnailFileRef
            .putFile(File(videoModel.thumbnail!))
            .then((value) async {
          final url = await value.ref.getDownloadURL();
          videoModel = videoModel.copyWith(thumbnail: url);
        });
      }

      // Set the video data in Firestore.
      await videoRef.set(videoModel.toMap());

      // Update the number of videos in the associated course document.
      await _firestore.collection('courses').doc(video.courseId).update({
        'numberOfVideos': FieldValue.increment(1),
      });
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to ServerException.
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw ServerException to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to ServerException.
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  /// Retrieves a list of videos associated with the specified course.
  ///
  /// Returns a [Future] containing a list of [VideoModel] instances on success.
  @override
  Future<List<VideoModel>> getVideos(String courseId) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_auth);

      // Retrieve the videos associated with the course from Firestore.
      final videos = await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('videos')
          .get();

      // Map the Firestore documents to VideoModel instances.
      return videos.docs.map((doc) => VideoModel.fromMap(doc.data())).toList();
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to ServerException.
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw ServerException to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to ServerException.
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }
}
