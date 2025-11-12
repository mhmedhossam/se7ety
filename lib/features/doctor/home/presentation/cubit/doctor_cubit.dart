import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/core/helper/upload_image.dart';
import 'package:se7ety/features/auth/data/models/doctor.dart';
import 'package:se7ety/features/doctor/home/data/models/appointment_model.dart';
import 'package:se7ety/features/doctor/home/presentation/cubit/doctor_states.dart';

class DoctorHomeCubit extends Cubit<DoctorHomeStates> {
  DoctorHomeCubit() : super(DoctorHomeInitialState());
  var appointmentsCollection = FirebaseFirestore.instance.collection(
    "appointments",
  );
  var doctorCollection = FirebaseFirestore.instance.collection("doctor");
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  Doctor? doctor;

  List<AppointmentModel> appointments = [];
  Future<List<AppointmentModel>> getMyAppointments() async {
    try {
      emit(DoctorHomeLoadingState());

      QuerySnapshot<Map<String, dynamic>> snapshot =
          await appointmentsCollection.where("doc-id", isEqualTo: uid).get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.docs;
      for (var doc in docs) {
        appointments.add(AppointmentModel.fromJson(doc.data()));
      }
      emit(DoctorHomeSucceedState());

      return appointments;
    } catch (e) {
      emit(DoctorHomeFailureState());
      return [];
    }
  }

  updateAppointment(Map<String, dynamic> json) {
    try {
      emit(DoctorHomeLoadingState());

      appointmentsCollection.doc(json["id"]).update(json);
      emit(DoctorHomeSucceedState());
    } catch (e) {
      emit(DoctorHomeFailureState());
    }
  }

  deleteAppointment(Map<String, dynamic> json) async {
    try {
      await appointmentsCollection.doc(json["id"]).delete();

      appointments.removeWhere((a) => a.id == json["id"]);

      emit(DoctorHomeSucceedState());
    } catch (e) {
      emit(DoctorHomeFailureState());
    }
  }

  getDoctorData() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await doctorCollection
        .doc(uid)
        .get();

    doctor = Doctor.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  Future<void> pickImage() async {
    try {
      var pickImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (isClosed) return;
      emit(DoctorHomeLoadingState());

      var imagePath = pickImage?.path;
      File imageFile = File(imagePath!);
      var url = uploadImageToCloudinary(imageFile);
      doctor?.image = await url;
      doctorCollection.doc(uid).update(doctor!.toUpdateData());
      if (isClosed) return;
      emit(DoctorHomeSucceedState());
    } catch (e) {
      emit(DoctorHomeFailureState());
    }
  }
}
