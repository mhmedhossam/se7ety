import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/features/auth/data/models/enum.dart';

import 'widgets/custom_button_container.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.welcome),
            opacity: 0.6,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Gap(media.height * 0.05),

                Text(
                  "أهلا بيك ",
                  style: TextStyles.headline.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                Gap(10),
                Text("سحل واحجز عند دكتورك وانت فالبيت "),
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
                          "سجل دلوقتى كا",
                          style: TextStyles.subHeadline.copyWith(
                            color: AppColors.backgroundColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Gap(30),
                        CustomButtonContainer(
                          title: "دكتور",
                          onTap: () {
                            Navigation.push(
                              context,
                              Routes.loginScreen,
                              UserTypeEnum.doctor,
                            );
                          },
                        ),
                        CustomButtonContainer(
                          title: "مريض",
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
      ),
    );
  }
}
