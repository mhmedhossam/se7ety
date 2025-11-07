import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/services/local/sharedpref.dart';
import 'package:se7ety/features/auth/data/models/doctor.dart';
import 'package:se7ety/features/auth/data/models/enum.dart';
import 'package:se7ety/features/auth/data/models/patient.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_states.dart';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  var form = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var specializationController = TextEditingController();
  var phone1Controller = TextEditingController();
  var phone2Controller = TextEditingController();
  var bioController = TextEditingController();
  var openHourController = TextEditingController();
  var closeHourController = TextEditingController();
  var addressController = TextEditingController();
  var imagePath;
  bool? completeRegister;
  String? userName;
  String? uid;
  String? userKind;
  File? file;

  Future<void> register({required UserTypeEnum person}) async {
    try {
      emit(AuthLoadingState());
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      User? user = credential.user;
      uid = user?.uid;
      user?.updateDisplayName(nameController.text ?? "");
      userName = user?.displayName;

      if (person == UserTypeEnum.doctor) {
        var doctor = Doctor(
          name: nameController.text,
          email: emailController.text,
          uid: uid,
          rating: 3,
          completeDataRegister: false,
          userKind: "doctor",
        );

        FirebaseFirestore.instance
            .collection('doctor')
            .doc(uid)
            .set(doctor.toJson());
        //using updatePhotoUrl as a role
        FirebaseAuth.instance.currentUser?.updatePhotoURL("doctor");
      } else {
        var patient = Patient(
          name: nameController.text,
          email: emailController.text,
          uid: uid,
          userKind: "patient",
        );

        FirebaseFirestore.instance
            .collection('patient')
            .doc(uid)
            .set(patient.toJson());
        //using updatePhotoUrl as a role
        FirebaseAuth.instance.currentUser?.updatePhotoURL("patient");
      }

      emit(AuthSucceedState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailureState(message: "The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(
          AuthFailureState(
            message: "The account already exists for that email.",
          ),
        );
      } else {
        emit(AuthFailureState(message: 'error please try again'));
      }
    } catch (e) {
      emit(
        AuthFailureState(message: "somethings error please try again later"),
      );
    }
  }

  Future<void> login({required UserTypeEnum person}) async {
    emit(AuthLoadingState());

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      userName = credential.user?.displayName;
      uid = credential.user?.uid;

      if (person == UserTypeEnum.doctor) {
        DocumentSnapshot<Map<String, dynamic>> docUser = await FirebaseFirestore
            .instance
            .collection("doctor")
            .doc(uid)
            .get();
        Map<String, dynamic>? userMap = docUser.data();
        completeRegister = userMap?["complete_register"];
        userKind = userMap?["user_kind"];

        //using updatePhotoUrl as a role
        FirebaseAuth.instance.currentUser?.updatePhotoURL("doctor");
      } else {
        //using updatePhotoUrl as a role
        FirebaseAuth.instance.currentUser?.updatePhotoURL("patient");
      }
      emit(AuthSucceedState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailureState(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(
          AuthFailureState(message: 'Wrong password provided for that user.'),
        );
      } else {
        emit(AuthFailureState(message: 'error please try again'));
      }
    } catch (e) {
      emit(AuthFailureState(message: "error please try again"));
    }
  }

  Future<void> registerCompleteData() async {
    emit(AuthLoadingState());
    Doctor doctor = Doctor(
      phone1: phone1Controller.text,
      phone2: phone2Controller.text,
      uid: FirebaseAuth.instance.currentUser?.uid,
      openHour: openHourController.text,
      closeHour: closeHourController.text,
      address: addressController.text,
      bio: bioController.text,
      specialization: specializationController.text,
      completeDataRegister: true,
      image: imagePath,
    );
    try {
      await FirebaseFirestore.instance
          .collection("doctor")
          .doc(doctor.uid)
          .update(doctor.toUpdateData());
      emit(AuthSucceedState());
    } on FirebaseFirestore catch (e) {
      emit(AuthFailureState(message: e.toString()));
    }
  }
}
