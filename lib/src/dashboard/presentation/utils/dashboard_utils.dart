import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/src/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A utility class for Dashboard.
class DashboardUtils {
  /// This is a private constructor for the `DashboardUtils` class. By making
  /// the constructor private and const, you ensure that this utility class
  /// cannot be instantiated or extended. It's a common pattern in Dart to
  /// prevent the instantiation of utility classes.
  const DashboardUtils._();

  /// A stream that provides real-time user data from Firestore.
  ///
  /// This stream fetches and monitors changes to the user's document in the
  /// Firestore database. It returns a [Stream] of [LocalUserModel] objects
  /// representing the user's data.
  static Stream<LocalUserModel> get userDataStream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => LocalUserModel.fromMap(event.data()!));
}
