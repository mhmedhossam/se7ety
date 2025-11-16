import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/features/doctor/home/data/models/appointment_model.dart';
import 'package:se7ety/features/patient/appointment/presentation/cubit/appoint_cubit.dart';

class CustomExpansionTile extends StatelessWidget {
  final AppointmentModel appointmentModel;
  final AppointCubit cubit;

  const CustomExpansionTile({
    super.key,
    required this.appointmentModel,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    bool getDate() {
      return appointmentModel.date ==
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).toString().split(' ')[0];
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),

          color: AppColors.fillColor,
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.all(20),
          childrenPadding: EdgeInsets.fromLTRB(20, 5, 20, 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColors.fillColor,
          collapsedIconColor: AppColors.primaryColor,
          title: Text(
            appointmentModel.docName ?? "",
            style: TextStyles.title.copyWith(color: AppColors.primaryColor),
          ),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10),

              Row(
                children: [
                  CustomTextIcon(
                    title: appointmentModel.date ?? "",
                    icon: Icons.date_range,
                  ),
                  Spacer(),
                  getDate()
                      ? Text(
                          "اليوم",
                          style: TextStyles.small.copyWith(color: Colors.green),
                        )
                      : SizedBox.shrink(),
                ],
              ),
              Gap(10),
              CustomTextIcon(
                title: appointmentModel.time ?? "",
                icon: Icons.watch_later_outlined,
              ),
            ],
          ),
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text("اسم المريض: ${appointmentModel.patientName}"),
            ),
            CustomTextIcon(
              title: appointmentModel.docAddress ?? "",
              icon: Icons.location_on,
            ),
            Gap(20),
            MainButton(
              onPressed: () {
                cubit.deleteAppointment(appointmentModel.toJson());
              },
              text: "حذف الحجز ",
              bgColor: AppColors.redAccent,
              textColor: AppColors.backgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  const CustomTextIcon({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryColor),
        SizedBox(
          width: 200,
          child: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
