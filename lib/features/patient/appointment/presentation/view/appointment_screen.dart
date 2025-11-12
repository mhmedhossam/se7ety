import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/widgets/loading.dart';
import 'package:se7ety/features/patient/appointment/presentation/cubit/appoint_cubit.dart';
import 'package:se7ety/features/patient/appointment/presentation/cubit/appoint_state.dart';

import '../widgets/list_builder_appointments_card.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AppointCubit>();
    String j = "شارع الجامعه تقاطع حلمى وعلاء";
    return Scaffold(
      appBar: AppBar(title: Text("مواعيد الحجز ")),
      body: BlocBuilder<AppointCubit, AppointStates>(
        builder: (context, state) {
          if (state is AppointLoadingState) {
            return Center(child: LoadingWidget());
          } else if (state is AppointSucceedState) {
            if (cubit.appointments.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.noSearch, height: 200),
                    Text("لا يوجد حجوزات حاليا "),
                  ],
                ),
              );
            } else {
              return ListBuilderAppointmentsCard(cubit: cubit);
            }
          } else {
            return Center(child: Text("حدث خطأ ما "));
          }
        },
      ),
    );
  }
}
