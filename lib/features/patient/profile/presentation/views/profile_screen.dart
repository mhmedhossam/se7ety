import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/helper/upload_image.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/core/widgets/dialogs.dart';
import 'package:se7ety/core/widgets/loading.dart';
import 'package:se7ety/features/auth/presentation/widgets/custom_align_text.dart';
import 'package:se7ety/features/patient/profile/presentation/cubit/profile_cubit.dart';
import 'package:se7ety/features/patient/profile/presentation/cubit/profile_states.dart';

import '../widgets/custom_contact_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigation.push(
                context,
                Routes.settingScreen,
                context.read<ProfileCubit>(),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
        title: Text("الحساب الشخصى"),
      ),
      body: BlocConsumer<ProfileCubit, ProfileStates>(
        buildWhen: (previous, current) =>
            current is ProfileLoadingState ||
            current is ProfileSucceedState ||
            current is ProfileFailureState ||
            current is ImageUpSucceedState,
        listener: (context, state) {
          if (state is ImageUpLoadingState) {
            showLoadingDialog(context);
          } else if (state is ImageUpSucceedState) {
            Navigation.pop(context);
            showMyDialog(
              context,
              "تم رفع الصورة بنجاح",
              DialogIconType.success,
            );
          } else if (state is ImageUpFailureState) {
            Navigation.pop(context);

            showMyDialog(
              context,
              "حدث خطأ ما أعد المحاوله",
              DialogIconType.error,
            );
          }
        },
        builder: (context, state) {
          var cubit = context.read<ProfileCubit>();
          if (state is ProfileLoadingState || state is ProfileLoadingState) {
            return Center(child: LoadingWidget());
          } else if (state is ProfileFailureState) {
            return Center(child: Image.asset(AppImages.noScheduled));
          } else if (state is ProfileSucceedState ||
              state is ImageUpSucceedState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(22),
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
                                child: cubit.patient?.imageUrl != null
                                    ? CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        height: 130,
                                        width: 130,
                                        placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(),
                                        ),

                                        imageUrl: cubit.patient?.imageUrl ?? "",
                                      )
                                    : Icon(
                                        CupertinoIcons.person_circle_fill,
                                        size: 130,
                                        color: AppColors.primaryColor
                                            .withValues(alpha: 0.8),
                                      ),
                              ),
                              cubit.patient?.imageUrl == null
                                  ? Positioned.directional(
                                      bottom: 5,
                                      start: 5,
                                      textDirection: TextDirection.rtl,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            AppColors.backgroundColor,
                                        radius: 22,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
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
                                cubit.patient?.name ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.title.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              Gap(10),
                              Text(
                                cubit.patient?.city ?? "لم تضاف",
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
                    Text(
                      cubit.patient?.bio ?? "لم تضاف ",
                      style: TextStyles.body,
                    ),
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
                            title: cubit.patient?.email ?? "",
                            icon: Icons.mail_rounded,
                          ),
                          CustomContactListTile(
                            title: cubit.patient?.phone ?? "لم يضاف",
                            icon: Icons.phone,
                          ),
                        ],
                      ),
                    ),
                    Divider(),

                    Gap(20),
                    Text(
                      "حجوزاتى",
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(10),
                    cubit.appointmentList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.fillColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "اسم الدكتور:  ${cubit.appointmentList[i].docName ?? ""}",
                                            style: TextStyles.body,
                                          ),
                                          Text(
                                            "التاريخ:  ${cubit.appointmentList[i].date ?? ""}",
                                            style: TextStyles.body,
                                          ),
                                          Text(
                                            "الوقت:  ${cubit.appointmentList[i].time ?? ""}",
                                            style: TextStyles.body,
                                          ),
                                          Text(
                                            "وصف الحاله:  ${cubit.appointmentList[i].patientDesc ?? ""}",
                                            style: TextStyles.body,
                                          ),
                                        ],
                                      ),
                                    ),

                                    Text(
                                      "مكتمل ",
                                      style: TextStyles.body.copyWith(
                                        color: AppColors.lightGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: cubit.appointmentList.length,
                          )
                        : CustomAlignText(
                            text: "لا يوجد حجوزات سابقه ",
                            alignment: Alignment.center,
                          ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
