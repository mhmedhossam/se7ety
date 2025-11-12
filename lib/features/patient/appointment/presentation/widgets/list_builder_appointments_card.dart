import 'package:flutter/cupertino.dart';
import 'package:se7ety/features/patient/appointment/presentation/cubit/appoint_cubit.dart';
import 'package:se7ety/features/patient/appointment/presentation/widgets/custom_expansion_tile.dart';

class ListBuilderAppointmentsCard extends StatelessWidget {
  const ListBuilderAppointmentsCard({super.key, required this.cubit});

  final AppointCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i) {
        return CustomExpansionTile(
          appointmentModel: cubit.appointments[i],
          cubit: cubit,
        );
      },
      itemCount: cubit.appointments.length,
    );
  }
}
