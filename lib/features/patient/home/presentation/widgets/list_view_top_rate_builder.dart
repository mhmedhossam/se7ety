import 'package:flutter/material.dart';
import 'package:se7ety/core/services/firebase_services/firebase_services.dart';
import 'package:se7ety/features/auth/data/models/doctor.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/doctor_container.dart';

class ListViewTopRateBuilder extends StatelessWidget {
  const ListViewTopRateBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseServices.topRateDoctors(),

      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, i) {
              Doctor doctorModel = Doctor.fromJson(
                snapshot.data?.docs[i].data() as Map<String, dynamic>,
              );
              if (doctorModel.specialization != null) {
                return DoctorContainer(doctorModel: doctorModel);
              }
              return null;
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
