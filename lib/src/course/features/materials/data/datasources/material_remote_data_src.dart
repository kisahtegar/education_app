// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/datasource_utils.dart';
import 'package:education_app/src/course/features/materials/data/models/resource_model.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Abstract class representing the remote data source for material-related operations.
abstract class MaterialRemoteDataSrc {
  /// Retrieves a list of materials associated with a specified course.
  ///
  /// Returns a [Future] containing a list of [ResourceModel] instances on success.
  /// Throws a [ServerException] if any error occurs during the operation.
  Future<List<ResourceModel>> getMaterials(String courseId);

  /// Adds a new material to the remote data source.
  ///
  /// Takes a [Resource] instance as input and returns a [Future] indicating
  /// the success or failure of the operation. Throws a [ServerException] on failure.
  Future<void> addMaterial(Resource material);
}

/// Implementation of the [MaterialRemoteDataSrc] interface responsible for interacting
/// with material-related data from a remote source.
class MaterialRemoteDataSrcImpl implements MaterialRemoteDataSrc {
  /// Constructs a [MaterialRemoteDataSrcImpl] instance with the required dependencies.
  const MaterialRemoteDataSrcImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _auth = auth,
        _firestore = firestore,
        _storage = storage;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  /// Adds a new material to the remote data source.
  ///
  /// Takes a [Resource] instance as input and returns a [Future] indicating
  /// the success or failure of the operation.
  @override
  Future<void> addMaterial(Resource material) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_auth);

      // Create a reference to the material document in Firestore.
      final materialRef = _firestore
          .collection('courses')
          .doc(material.courseId)
          .collection('materials')
          .doc();

      // Create a ResourceModel instance with a unique ID.
      var materialModel =
          (material as ResourceModel).copyWith(id: materialRef.id);

      // If the material is a file, upload it to Firebase Storage.
      if (materialModel.isFile) {
        final materialFileRef = _storage.ref().child(
              'courses/${materialModel.courseId}/materials/${materialModel.id}/material',
            );
        await materialFileRef
            .putFile(File(materialModel.fileURL))
            .then((value) async {
          final url = await value.ref.getDownloadURL();
          materialModel = materialModel.copyWith(fileURL: url);
        });
      }

      // Set the material data in Firestore.
      await materialRef.set(materialModel.toMap());

      // Update the number of materials in the associated course document.
      await _firestore.collection('courses').doc(material.courseId).update({
        'numberOfMaterials': FieldValue.increment(1),
      });
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to ServerException.
      throw ServerException(
        message: e.message ?? 'Unknown error',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw ServerException to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to ServerException.
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  /// Retrieves a list of materials associated with the specified course.
  ///
  /// Returns a [Future] containing a list of [ResourceModel] instances on success.
  @override
  Future<List<ResourceModel>> getMaterials(String courseId) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_auth);

      // Retrieve the materials associated with the course from Firestore.
      final materialsRef = _firestore
          .collection('courses')
          .doc(courseId)
          .collection('materials');
      final materials = await materialsRef.get();

      // Map the Firestore documents to ResourceModel instances.
      return materials.docs
          .map((e) => ResourceModel.fromMap(e.data()))
          .toList();
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to ServerException.
      throw ServerException(
        message: e.message ?? 'Unknown error',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw ServerException to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to ServerException.
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }
}
