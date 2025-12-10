import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/features/auth/data/models/enum.dart';
import 'package:flutter/widgets.dart';
import 'widgets/custom_button_container.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  UserTypeEnum? SelectedRow;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,

            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AppImages.welcome),
                opacity: 0.6,
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: media.height * 0.07,
            child: GestureDetector(
              onTap: () {
                var currentLocal = context.locale;
                var newLocal = currentLocal.languageCode == 'en' ? 'ar' : 'en';
                context.setLocale(Locale(newLocal));
              },
              child: Container(
                width: 100,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.darkColor),
                  color: AppColors.backgroundColor,
                ),
                child: Row(
                  children: [
                    Icon(Icons.language, color: AppColors.primaryColor),
                    Gap(5),
                    Text("language".tr()),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(media.height * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "welcome".tr(),
                        style: TextStyles.headline.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Gap(10),
                      Text("sign and book".tr()),
                    ],
                  ),
                  Spacer(),

                  Container(
                    width: double.infinity,
                    height: media.height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.primaryColor.withValues(alpha: 0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            "sign as".tr(),
                            style: TextStyles.subHeadline.copyWith(
                              color: AppColors.backgroundColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Gap(30),
                          CustomButtonContainer(
                            title: "doctor".tr(),
                            onTap: () {
                              Navigation.push(
                                context,
                                Routes.loginScreen,
                                UserTypeEnum.doctor,
                              );
                            },
                          ),
                          CustomButtonContainer(
                            title: "patient".tr(),
                            onTap: () {
                              Navigation.push(
                                context,
                                Routes.loginScreen,
                                UserTypeEnum.patient,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(media.height * 0.04),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class chooseButton extends StatelessWidget {
  final void Function() onTap;
  bool isSelected;
  chooseButton({super.key, required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.fillColor,
          border: Border.all(color: AppColors.darkColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text("دكتور ")),
      ),
    );
  }
}
