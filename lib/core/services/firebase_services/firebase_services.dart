import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  static CollectionReference doctorCollection = FirebaseFirestore.instance
      .collection("doctor");
  static CollectionReference patientCollection = FirebaseFirestore.instance
      .collection("patient");

  static String? displayName = FirebaseAuth.instance.currentUser?.displayName;

  static Future<QuerySnapshot<Object?>> searchDoctor(String? searchValue) {
    return doctorCollection.orderBy("name").startAt([searchValue]).endAt([
      "$searchValue\uf8ff",
    ]).get();
  }

  static Stream<QuerySnapshot<Object?>> searchStreamDoctor(
    String? searchValue,
  ) {
    return doctorCollection.orderBy("name").startAt([searchValue]).endAt([
      "$searchValue\uf8ff",
    ]).snapshots();
  }

  static Future<QuerySnapshot<Object?>> specializationSearch(
    String specialization,
  ) {
    return doctorCollection
        .where("specialization", isEqualTo: specialization)
        .get();
  }

  static Future<QuerySnapshot<Object?>> topRateDoctors() {
    return doctorCollection
        .orderBy("rating", descending: true)
        .where("rating", isGreaterThan: 3)
        .get();
  }
}
