import 'package:flutter/material.dart';
import 'package:se7ety/core/services/firebase_services/firebase_services.dart';
import 'package:se7ety/features/auth/data/models/doctor.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/doctor_container.dart';

import '../../../../../core/widgets/no_search_widget.dart';

class SearchResultScreen extends StatelessWidget {
  final String value;
  const SearchResultScreen({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" نتائج البحث")),
      body: FutureBuilder(
        future: FirebaseServices.searchDoctor(value),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            if (snapShot.data!.docs.isEmpty) {
              return NoSearchWidget(text: "لا يوجد دكاتره حاليا بهذا الاسم ");
            } else {
              return ListView.builder(
                itemCount: snapShot.data?.docs.length,
                itemBuilder: (context, i) {
                  return DoctorContainer(
                    doctorModel: Doctor.fromJson(
                      snapShot.data!.docs[i].data() as Map<String, dynamic>,
                    ),
                   
                  );
                },
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
