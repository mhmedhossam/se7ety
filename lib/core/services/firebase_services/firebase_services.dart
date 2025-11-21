import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/widgets/dialogs.dart';
import 'package:se7ety/features/auth/data/models/patient.dart';

class FirebaseServices {
  static CollectionReference doctorCollection = FirebaseFirestore.instance
      .collection("doctor");
  static CollectionReference patientCollection = FirebaseFirestore.instance
      .collection("patient");
  static CollectionReference appointmentCollection = FirebaseFirestore.instance
      .collection("appointments");

  String? displayName = FirebaseAuth.instance.currentUser?.displayName;

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

  static setAppointment(Map<String, dynamic> data, BuildContext context) async {
    try {
      showLoadingDialog(context);

      var res = appointmentCollection.doc();
      data['id'] = res.id;
      res.set(data).then((_) {
        Navigation.pop(context);
        showMyDialog(context, "تم الحجز بنجاح", DialogIconType.success, () {
          Navigation.pushAndRemoveUntil(context, Routes.mainScreen);
        });
      });
    } catch (e) {
      Navigation.pop(context);
      showMyDialog(context, "حدث خطأ أعد المحاوله لاحقا", DialogIconType.error);
    }
  }
}
