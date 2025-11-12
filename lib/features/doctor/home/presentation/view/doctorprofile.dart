import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/features/doctor/home/presentation/cubit/doctor_cubit.dart';
import 'package:se7ety/features/doctor/home/presentation/cubit/doctor_states.dart';
import 'package:se7ety/features/patient/profile/presentation/widgets/custom_contact_list_tile.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("بيانات الدكتور")),
      body: BlocBuilder<DoctorHomeCubit, DoctorHomeStates>(
        builder: (context, state) {
          var cubit = context.read<DoctorHomeCubit>();
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(200),
                        onTap: () {
                          cubit.pickImage();
                        },
                        child: Stack(
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              child: cubit.doctor?.image != null
                                  ? CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      height: 130,
                                      width: 130,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),

                                      imageUrl: cubit.doctor?.image ?? "",
                                    )
                                  : Icon(
                                      CupertinoIcons.person_circle_fill,
                                      size: 130,
                                      color: AppColors.primaryColor.withValues(
                                        alpha: 0.8,
                                      ),
                                    ),
                            ),
                            // cubit.patient?.imageUrl == null
                            Positioned.directional(
                              bottom: 5,
                              start: 5,
                              textDirection: TextDirection.rtl,
                              child: CircleAvatar(
                                backgroundColor: AppColors.backgroundColor,
                                radius: 22,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            // : SizedBox.shrink(),
                          ],
                        ),
                      ),
                      Gap(30),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              cubit.doctor?.name ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.title.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Gap(10),
                            Text(
                              cubit.doctor?.specialization ?? "",
                              style: TextStyles.body,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(30),
                  Text(
                    "نبذه تعريفيه",
                    style: TextStyles.body.copyWith(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(10),
                  Text(cubit.doctor?.bio ?? "", style: TextStyles.body),
                  Gap(10),

                  Divider(),
                  Gap(20),

                  Text(
                    "معلومات التواصل,",
                    style: TextStyles.body.copyWith(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(10),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.fillColor,
                    ),
                    child: Column(
                      children: [
                        CustomContactListTile(
                          title:
                              "open ${cubit.doctor?.openHour ?? ""}\nclose ${cubit.doctor?.closeHour ?? ""}",
                          icon: Icons.lock_clock,
                        ),
                        CustomContactListTile(
                          title: cubit.doctor?.address ?? "",
                          icon: Icons.location_city,
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.fillColor,
                    ),
                    child: Column(
                      children: [
                        CustomContactListTile(
                          title: cubit.doctor?.phone1 ?? "لم يضاف",
                          icon: Icons.phone_iphone,
                        ),
                        CustomContactListTile(
                          title: cubit.doctor?.phone2 ?? "لم يضاف",
                          icon: Icons.phone,
                        ),
                      ],
                    ),
                  ),
                  Gap(20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
