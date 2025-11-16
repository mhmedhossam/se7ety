import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/core/helper/upload_image.dart';
import 'package:se7ety/features/auth/data/models/patient.dart';
import 'package:se7ety/features/doctor/home/data/models/appointment_model.dart';
import 'package:se7ety/features/patient/profile/presentation/cubit/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  var form = GlobalKey<FormState>();
  ProfileCubit() : super(ProfileInitialState());
  var editController = TextEditingController();
  List<AppointmentModel> appointmentList = [];
  Patient? patient;
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  var patientCollection = FirebaseFirestore.instance.collection("patient");
  var appointmentCollection = FirebaseFirestore.instance.collection(
    "appointments",
  );
  Future<void> getProfileData() async {
    emit(ProfileLoadingState());
    if (isClosed) return;
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("patient")
          .doc(uid)
          .get();

      patient = Patient.fromJson(snapshot.data()!);
      if (isClosed) return;
      emit(ProfileSucceedState());
    } catch (e) {
      emit(ProfileFailureState());
    }
  }

  Future<void> getoldAppointment() async {
    emit(ProfileLoadingState());
    if (isClosed) return;
    QuerySnapshot<Map<String, dynamic>> snapshot = await appointmentCollection
        .where("patient-id", isEqualTo: uid)
        .where("is-complete", isEqualTo: true)
        .get();

    for (var doc in snapshot.docs) {
      AppointmentModel appointmentModel = AppointmentModel.fromJson(doc.data());
      appointmentList.add(appointmentModel);
    }
    emit(ProfileSucceedState());
  }

  Future<void> pickImage() async {
    try {
      var pickImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (isClosed) return;
      emit(ImageUpLoadingState());

      var imagePath = pickImage?.path;
      File imageFile = File(imagePath!);
      var url = uploadImageToCloudinary(imageFile);
      patient?.imageUrl = await url;
      patientCollection.doc(uid).update(patient!.toJsonUpdateData());
      if (isClosed) return;
      emit(ImageUpSucceedState());
    } catch (e) {
      emit(ImageUpFailureState());
    }
  }

  editSetting() async {
    try {
      await patientCollection.doc(uid).update(patient!.toJsonUpdateData());
      if (patient?.name != null) {
        FirebaseAuth.instance.currentUser?.updateDisplayName(patient?.name);
      }

      emit(ProfileSucceedState());
    } catch (e) {
      emit(ProfileFailureState());
    }
  }

  editDisplayName(String value) async {
    await FirebaseAuth.instance.currentUser?.updateDisplayName(value);
  }
}
