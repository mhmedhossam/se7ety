import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/services/firebase_services/firebase_services.dart';
import 'package:se7ety/core/widgets/loading.dart';
import 'package:se7ety/core/widgets/no_search_widget.dart';
import 'package:se7ety/features/auth/data/models/doctor.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/doctor_container.dart';

class SearchStreamList extends StatelessWidget {
  const SearchStreamList({super.key, required this.searchDoctor});

  final TextEditingController searchDoctor;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseServices.searchStreamDoctor(searchDoctor.text),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (searchDoctor.text.isEmpty) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: NoSearchWidget(text: "قم بالبحث عن اسم الدكتور"),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, i) {
                  return DoctorContainer(
                    doctorModel: Doctor.fromJson(
                      snapshot.data?.docs[i].data() as Map<String, dynamic>,
                    ),
                  );
                },
              ),
            );
          }
        } else {
          return Center(child: LoadingWidget());
        }
      },
    );
  }
}
