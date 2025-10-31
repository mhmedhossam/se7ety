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
  String? userName;
  Future<void> register({required UserTypeEnum person}) async {
    try {
      emit(AuthLoadingState());
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      User? user = credential.user;
      user?.updateDisplayName(nameController.text ?? "");
      userName = user?.displayName;

      if (person == UserTypeEnum.doctor) {
        var doctor = Doctor(
          name: nameController.text,
          email: emailController.text,
          uid: user?.uid,
          rating: 3,
        );

        FirebaseFirestore.instance
            .collection('doctor')
            .doc(user?.uid)
            .set(doctor.toJson());
      } else {
        var patient = Patient(
          name: nameController.text,
          email: emailController.text,
          uid: user?.uid,
        );

        FirebaseFirestore.instance
            .collection('patient')
            .doc(user?.uid)
            .set(patient.toJson());
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

  Future<void> login() async {
    emit(AuthLoadingState());

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      userName = credential.user?.displayName;
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
}
