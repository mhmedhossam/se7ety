import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/features/auth/data/models/doctor.dart';

class DoctorContainer extends StatelessWidget {
  final Doctor doctorModel;
  const DoctorContainer({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 5),

      padding: EdgeInsetsDirectional.fromSTEB(10, 3, 0, 3),
      width: double.infinity,

      decoration: BoxDecoration(
        color: AppColors.lightBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () {
          Navigation.push(context, Routes.doctorDetailsScreen, doctorModel);
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            Text("${doctorModel.rating ?? ""}"),
            Icon(Icons.star, color: Colors.amber),
          ],
        ),
        leading: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          // width: 30,
          // decoration: BoxDecoration(),
          child: CachedNetworkImage(
            width: 55,

            imageUrl: doctorModel.image ?? "",
            fit: BoxFit.cover,

            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, str, url) => Icon(
              CupertinoIcons.person_alt_circle_fill,
              color: AppColors.primaryColor,
              size: 52,
            ),
          ),
        ),
        title: Text(
          doctorModel.name ?? "",
          style: TextStyles.title.copyWith(color: AppColors.primaryColor),
        ),

        subtitle: Text(doctorModel.specialization ?? ""),
      ),
    );
  }
}
