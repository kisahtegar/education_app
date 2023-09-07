// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/src/chat/data/models/group_model.dart';
import 'package:education_app/src/course/data/models/course_model.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// An abstract class defining the remote data source methods for course-related data.
abstract class CourseRemoteDataSrc {
  const CourseRemoteDataSrc();

  /// Fetches a list of course models.
  Future<List<CourseModel>> getCourses();

  /// Adds a new course to the remote data source.
  Future<void> addCourse(Course course);
}

/// Implementation of [CourseRemoteDataSrc] that interacts with Firestore and Firebase Storage.
class CourseRemoteDataSrcImpl implements CourseRemoteDataSrc {
  const CourseRemoteDataSrcImpl({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseStorage firebaseStorage,
    required FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore,
        _firebaseStorage = firebaseStorage,
        _firebaseAuth = firebaseAuth;

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;
  final FirebaseAuth _firebaseAuth;

  /// Adds a new course to the remote data source.
  @override
  Future<void> addCourse(Course course) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      // Create a reference for the new course and group.
      final courseRef = _firebaseFirestore.collection('courses').doc();
      final groupRef = _firebaseFirestore.collection('groups').doc();

      // Copy the course data and assign generated IDs.
      var courseModel = (course as CourseModel).copyWith(
        id: courseRef.id,
        groupId: groupRef.id,
      );

      if (courseModel.imageIsFile) {
        final imageRef = _firebaseStorage.ref().child(
              'courses/${courseModel.id}/profile_image/${courseModel.title}--pfp',
            );
        await imageRef.putFile(File(courseModel.image!)).then((value) async {
          final url = await value.ref.getDownloadURL();
          courseModel = courseModel.copyWith(image: url);
        });
      }

      // Save the course to Firestore.
      await courseRef.set(courseModel.toMap());

      // Create a corresponding group.
      final group = GroupModel(
        id: groupRef.id,
        courseId: courseRef.id,
        name: course.title,
        members: const [],
        groupImageUrl: courseModel.image,
      );

      // Save the group to Firestore.
      return groupRef.set(group.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occured',
        statusCode: e.code,
      );
    } on ServerException {
      // It can escape the catch block.
      rethrow;
    } catch (e) {
      // Else if it actually comes to the general catch block.
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  /// Fetches a list of course models from the remote data source.
  @override
  Future<List<CourseModel>> getCourses() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      // Fetch and map course data from Firestore.
      return _firebaseFirestore.collection('courses').get().then(
            (value) => value.docs
                .map((doc) => CourseModel.fromMap(doc.data()))
                .toList(),
          );
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occured',
        statusCode: e.code,
      );
    } on ServerException {
      // It can escape the catch block.
      rethrow;
    } catch (e) {
      // Else if it actually comes to the general catch block.
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }
}
