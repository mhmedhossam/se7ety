import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/features/auth/data/models/doctor.dart';
import 'package:se7ety/features/auth/data/models/enum.dart';
import 'package:se7ety/features/auth/data/models/patient.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_states.dart';

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
          rating: 5,
          completeDataRegister: false,
          userKind: "doctor",
        );

        FirebaseFirestore.instance
            .collection('doctor')
            .doc(uid)
            .set(doctor.toJson());
        //using updatePhotoUrl as a role
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
        emit(AuthFailureState(message: "الباسورد الذى ادخلته ضعيف"));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailureState(message: "هذا الاكونت موجود بالفعل "));
      } else {
        emit(AuthFailureState(message: 'خطأ حاول مره أخرى '));
      }
    } catch (e) {
      emit(AuthFailureState(message: "حدث شىء ما خطأ يرجى المحاوله مره اخرى "));
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
        if (userKind == "doctor") {
          if (completeRegister == true) {
            FirebaseAuth.instance.currentUser?.updatePhotoURL("doctor");
          }
          emit(AuthSucceedState());
        } else {
          await FirebaseAuth.instance.signOut();
          emit(AuthFailureState(message: "هذا الاكونت مسجل كمريض"));
        }
      } else if (person == UserTypeEnum.patient) {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
            .instance
            .collection("patient")
            .doc(uid)
            .get();
        Map<String, dynamic>? userMap = userDoc.data();

        userKind = userMap?["user_kind"];

        if (userKind == "patient") {
          //using updatePhotoUrl as a role
          FirebaseAuth.instance.currentUser?.updatePhotoURL("patient");
          emit(AuthSucceedState());
        } else {
          await FirebaseAuth.instance.signOut();
          emit(AuthFailureState(message: "هذا الاكونت مسجل ك دكتور "));
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailureState(message: 'هذا الايميل ليس مسجل '));
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        emit(AuthFailureState(message: 'خطأ فى الايميل أو  الباسورد '));
      } else {
        log(e.toString());
        emit(AuthFailureState(message: 'خطأ حاول مره أخرى '));
      }
    } catch (e) {
      emit(AuthFailureState(message: 'خطأ حاول مره أخرى '));
    }
  }

  Future<void> registerCompleteData() async {
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
      emit(AuthLoadingState());
      await FirebaseFirestore.instance
          .collection("doctor")
          .doc(doctor.uid)
          .update(doctor.toUpdateData());
      FirebaseAuth.instance.currentUser?.updatePhotoURL("doctor");

      emit(AuthSucceedState());
    } on FirebaseFirestore catch (e) {
      emit(AuthFailureState(message: "خطأ اعد أكمال البيانات مره اخرى"));
    }
  }
}
