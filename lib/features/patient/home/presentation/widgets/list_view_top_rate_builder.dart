import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/services/firebase_services/firebase_services.dart';
import 'package:se7ety/features/patient/home/data/models/doctor_model.dart';
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
              DoctorModel doctorModel = DoctorModel.fromJson(
                snapshot.data?.docs[i].data(),
              );
              if (doctorModel.subTitle != null) {
                return DoctorContainer(doctorModel: doctorModel, onTap: () {});
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
