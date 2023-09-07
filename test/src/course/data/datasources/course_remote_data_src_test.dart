import 'package:education_app/src/course/data/datasources/course_remote_data_src.dart';
import 'package:education_app/src/course/data/models/course_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  late CourseRemoteDataSrc remoteDataSrc;
  late FakeFirebaseFirestore firebaseFirestore;
  late MockFirebaseAuth firebaseAuth;
  late MockFirebaseStorage firebaseStorage;

  setUp(() async {
    firebaseFirestore = FakeFirebaseFirestore();

    final user = MockUser(
      uid: 'uid',
      email: 'email',
      displayName: 'displayName',
    );

    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    firebaseAuth = MockFirebaseAuth(mockUser: user);
    await firebaseAuth.signInWithCredential(credential);

    firebaseStorage = MockFirebaseStorage();
    remoteDataSrc = CourseRemoteDataSrcImpl(
      firebaseFirestore: firebaseFirestore,
      firebaseStorage: firebaseStorage,
      firebaseAuth: firebaseAuth,
    );
  });

  group('addCourse', () {
    test('should add the given course to the firestore collection', () async {
      // Arrange
      final course = CourseModel.empty();

      // Act
      await remoteDataSrc.addCourse(course);

      // Assert
      final firestoreData = await firebaseFirestore.collection('courses').get();
      // make sure length on docs not 0, after we addCourse.
      expect(firestoreData.docs.length, 1);

      final courseRef = firestoreData.docs.first;
      // Make sure id on properties is same as the document id.
      expect(courseRef.data()['id'], courseRef.id);

      final groupData = await firebaseFirestore.collection('groups').get();
      expect(groupData.docs.length, 1);

      final groupRef = groupData.docs.first;
      expect(groupRef.data()['id'], groupRef.id);

      // make sure the group that was created is the courses group for the
      // course
      expect(courseRef.data()['groupId'], groupRef.id);
      expect(groupRef.data()['courseId'], courseRef.id);
    });
  });

  group('getCourses', () {
    test(
      'should return a List<Course> when the call is successful',
      () async {
        // Arrange
        final firstDate = DateTime.now();
        final secondDate = DateTime.now().add(const Duration(seconds: 20));
        final expectedCourses = [
          CourseModel.empty().copyWith(createdAt: firstDate),
          CourseModel.empty().copyWith(
            createdAt: secondDate,
            id: '1',
            title: 'Course 1',
          ),
        ];

        for (final course in expectedCourses) {
          await firebaseFirestore.collection('courses').add(course.toMap());
        }

        // Act
        final result = await remoteDataSrc.getCourses();

        // Assert
        expect(result, expectedCourses);
      },
    );
  });
}
