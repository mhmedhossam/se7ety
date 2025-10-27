import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                Gap(30),

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
                  height: 280,
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
                        CustomButtonContainer(title: "دكتور", onTap: () {}),
                        CustomButtonContainer(title: "مريض", onTap: () {}),
                      ],
                    ),
                  ),
                ),
                Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonContainer extends StatelessWidget {
  final String title;
  final Function() onTap;

  const CustomButtonContainer({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColors.fillColor.withValues(alpha: 0.8),
          ),

          child: Center(child: Text(title, style: TextStyles.title)),
        ),
      ),
    );
  }
}
