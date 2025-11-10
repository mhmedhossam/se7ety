import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/core/widgets/custom_text_field.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/features/patient/profile/presentation/cubit/profile_cubit.dart';
import 'package:se7ety/features/patient/profile/presentation/cubit/profile_states.dart';

import '../widgets/account_setting_card.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إعدادات الحساب")),

      body: BlocBuilder<ProfileCubit, ProfileStates>(
        builder: (context, state) {
          var cubit = context.read<ProfileCubit>();
          if (state is ProfileLoadingState) {
            return Center(
              child: LottieBuilder.asset(
                "assets/images/loading.json",
                height: 70,
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                AccountSettingCard(
                  onTap: () {
                    editDialog(
                      context: context,
                      hintText: "أدخل الاسم الجديد ",
                      cubit: cubit,
                      onChanged: (value) {
                        cubit.patient?.name = value;
                      },
                      title: "تعديل الاسم ",
                    );
                  },
                  title: "الاسم",
                  desc: cubit.patient?.name ?? "لم يتم ادخاله ",
                ),
                AccountSettingCard(
                  onTap: () {
                    editDialog(
                      context: context,
                      hintText: "رقم التلفون الجديد",
                      cubit: cubit,
                      onChanged: (value) {
                        cubit.patient?.phone = value;
                      },
                      title: "تعديل رقم التلفون  ",
                    );
                  },
                  title: "رقم التلفون",
                  desc: cubit.patient?.phone ?? "لم يتم ادخاله ",
                ),
                AccountSettingCard(
                  onTap: () {
                    editDialog(
                      context: context,
                      hintText: "أدخل المدينة ",
                      cubit: cubit,
                      onChanged: (value) {
                        cubit.patient?.city = value;
                      },
                      title: "تعديل المدينة ",
                    );
                  },
                  title: "المدينة",
                  desc: cubit.patient?.city ?? "لم يتم ادخاله ",
                ),
                AccountSettingCard(
                  onTap: () {
                    editDialog(
                      context: context,
                      hintText: "أدخل نبذه تعريفية عنك",
                      cubit: cubit,
                      onChanged: (value) {
                        cubit.patient?.bio = value;
                      },
                      title: " نبذه تعريفية  ",
                    );
                  },
                  title: "نبذة تعريفية",
                  desc: cubit.patient?.bio ?? "لم يتم ادخاله ",
                ),
                AccountSettingCard(
                  onTap: () {
                    editDialog(
                      context: context,
                      hintText: "ادخل العمر",
                      cubit: cubit,
                      onChanged: (value) {
                        cubit.patient?.age = value;
                      },
                      title: "تعديل العمر ",
                    );
                  },
                  title: " العمر",
                  desc: cubit.patient?.age ?? "لم يتم ادخاله ",
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> editDialog({
    required BuildContext context,
    required ProfileCubit cubit,
    required void Function(String) onChanged,
    required String title,
    required String hintText,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: cubit.form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Spacer(flex: 2),
                      Text(title, style: TextStyles.body),
                      Spacer(flex: 1),

                      IconButton(
                        onPressed: () {
                          Navigation.pop(context);
                          cubit.editController.clear();
                        },
                        icon: Icon(Icons.cancel, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  Gap(30),
                  CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "قم بإدخال البيانات المطلوبه قبل التأكيد";
                      }
                      return null;
                    },
                    minLine: 1,
                    maxLine: 3,
                    hintText: hintText,
                    controller: cubit.editController,
                    onChanged: onChanged,

                    // onChanged: onChanged,
                  ),

                  Gap(20),
                  MainButton(
                    onPressed: () {
                      if (cubit.form.currentState!.validate()) {
                        cubit.editSetting();
                        Navigation.pop(context);
                        cubit.editController.clear();
                      }
                    },
                    text: "حفظ التعديل",

                    bgColor: AppColors.primaryColor,
                    textColor: AppColors.backgroundColor,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
