import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/features/doctor/home/data/models/appointment_model.dart';
import 'package:se7ety/features/patient/appointment/presentation/cubit/appoint_state.dart';

class AppointCubit extends Cubit<AppointStates> {
  AppointCubit() : super(AppointInitialState());

  var appointmentsCollection = FirebaseFirestore.instance.collection(
    "appointments",
  );
  String? uid = FirebaseAuth.instance.currentUser?.uid;

  List<AppointmentModel> appointments = [];
  Future<List<AppointmentModel>> getMyAppointments() async {
    try {
      emit(AppointLoadingState());

      QuerySnapshot<Map<String, dynamic>> snapshot =
          await appointmentsCollection
              .where("patient-id", isEqualTo: uid)
              .where("is-complete", isEqualTo: false)
              .get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.docs;
      for (var doc in docs) {
        appointments.add(AppointmentModel.fromJson(doc.data()));
      }
      emit(AppointSucceedState());

      return appointments;
    } catch (e) {
      emit(AppointFailureState());
      return [];
    }
  }

  deleteAppointment(Map<String, dynamic> json) async {
    try {
      await appointmentsCollection.doc(json["id"]).delete();

      appointments.removeWhere((model) => model.id == json["id"]);

      emit(AppointSucceedState());
    } catch (e) {
      emit(AppointFailureState());
    }
  }
}
