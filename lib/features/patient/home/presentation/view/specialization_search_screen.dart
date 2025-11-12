import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/services/firebase_services/firebase_services.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/core/widgets/loading.dart';
import 'package:se7ety/core/widgets/no_search_widget.dart';
import 'package:se7ety/features/auth/data/models/doctor.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/doctor_container.dart';

class SpecializationSearchScreen extends StatelessWidget {
  final String specialization;
  const SpecializationSearchScreen({super.key, required this.specialization});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          specialization,
          style: TextStyles.title.copyWith(color: AppColors.backgroundColor),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseServices.specializationSearch(specialization),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            if (snapShot.data!.docs.isEmpty) {
              return NoSearchWidget(text: "لا يوجد دكاتره حاليا بهذا التخصص  ");
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
            return Center(child: LoadingWidget());
          }
        },
      ),
    );
  }
}
