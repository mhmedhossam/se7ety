import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/firebase_services/firebase_services.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/app_fonts.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/core/widgets/loading.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/features/doctor/home/data/models/appointment_model.dart';
import 'package:se7ety/features/doctor/home/presentation/cubit/doctor_cubit.dart';
import 'package:se7ety/features/doctor/home/presentation/cubit/doctor_states.dart';

import '../widget/custom_rich_text.dart';
import '../widget/list_view_patient_cards_builder.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigation.pushAndRemoveUntil(context, Routes.welcomeScreen);
          },
          icon: Icon(Icons.logout, color: AppColors.primaryColor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigation.push(
                context,
                Routes.doctorProfile,
                context.read<DoctorHomeCubit>(),
              );
            },
            icon: Icon(CupertinoIcons.person, color: AppColors.primaryColor),
          ),
        ],
        title: Text(
          "صـحٌتـى ",
          style: TextStyles.title.copyWith(color: AppColors.darkColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 30, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 15),
                child: RichText(
                  text: TextSpan(
                    style: TextStyles.title.copyWith(
                      fontFamily: AppFonts.cairoFamily,
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(text: "مرحبا, "),
                      TextSpan(
                        text: FirebaseServices().displayName,
                        style: TextStyles.title.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),

                      WidgetSpan(
                        alignment: PlaceholderAlignment.top,

                        child: Icon(
                          Icons.waving_hand,
                          color: AppColors.primaryColor,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 15, end: 30),
                child: Text(
                  "فيما يلي تفاصيل مواعيد المرضى الخاصة بك",
                  style: TextStyles.subHeadline,
                ),
              ),
              Gap(20),
              Align(
                alignment: Alignment.center,
                child: Text("--قائمه الحجوزات --", style: TextStyles.title),
              ),

              BlocBuilder<DoctorHomeCubit, DoctorHomeStates>(
                builder: (context, state) {
                  var cubit = context.read<DoctorHomeCubit>();

                  if (state is DoctorHomeSucceedState) {
                    if (cubit.appointments.isEmpty ||
                        cubit.appointments == []) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Gap(30),
                            Image.asset(AppImages.noSearch, height: 200),
                            Text("لا يوجد حجوزات حاليا "),
                          ],
                        ),
                      );
                    } else {
                      return ListViewPatientCardsBuilder(cubit: cubit);
                    }
                  } else if (state is DoctorHomeFailureState) {
                    return Center(child: Text("حدث خطأ ما "));
                  } else {
                    return Center(child: LoadingWidget());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PatientCard extends StatelessWidget {
  const PatientCard({
    super.key,
    required this.cubit,
    required this.appointmentModel,
  });
  final AppointmentModel appointmentModel;
  final DoctorHomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRichText(
            icon: CupertinoIcons.person,
            title: "اسم المريض : ",
            subTitle: appointmentModel.patientName ?? "",
          ),
          Gap(10),
          CustomRichText(
            icon: Icons.description,
            title: "وصف المريض :",
            subTitle: appointmentModel.patientDesc ?? "",
          ),
          Gap(10),

          CustomRichText(
            icon: Icons.date_range,
            title: "معاد الحجز :",
            subTitle: appointmentModel.date ?? "",
          ),
          Gap(20),
          CustomRichText(
            icon: Icons.date_range,
            title: "حالة الحجز: ",
            subTitle: appointmentModel.isComplete == true
                ? "تم الحضور"
                : "فى الانتظار ",
          ),
          Row(
            children: [
              appointmentModel.isComplete == false
                  ? Expanded(
                      child: MainButton(
                        onPressed: () {
                          appointmentModel.isComplete = true;
                          cubit.updateAppointment(
                            appointmentModel.toJsonUpdate(),
                          );
                        },
                        text: "تم انتهاء ",
                        bgColor: AppColors.primaryColor,
                        textColor: AppColors.backgroundColor,
                      ),
                    )
                  : SizedBox(),
              Gap(10),
              Expanded(
                child: MainButton(
                  onPressed: () {
                    cubit.deleteAppointment(appointmentModel.toJson());
                  },
                  text: "حذف الحجز",
                  bgColor: AppColors.redAccent,
                  textColor: AppColors.backgroundColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
