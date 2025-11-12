import 'package:flutter/cupertino.dart';
import 'package:se7ety/features/doctor/home/presentation/cubit/doctor_cubit.dart';
import 'package:se7ety/features/doctor/home/presentation/view/doctor_home.dart';

class ListViewPatientCardsBuilder extends StatelessWidget {
  const ListViewPatientCardsBuilder({super.key, required this.cubit});

  final DoctorHomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cubit.appointments.length,
      itemBuilder: (context, i) {
        return PatientCard(
          cubit: cubit,
          appointmentModel: cubit.appointments[i],
        );
      },
    );
  }
}
