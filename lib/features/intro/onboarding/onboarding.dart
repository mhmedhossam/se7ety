import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/features/intro/onboarding/models/on_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pageIndex = 0;

  final List<OnModel> pages = [
    OnModel(
      image: AppImages.on1,
      subtitle:
          "اكتشف مجموعه واسعه من الأطباء الخبراء والمتخصصين فى مختلف المجالات ",
      title: "ابحث عن دكتور متخصص",
    ),
    OnModel(
      image: AppImages.on2,
      subtitle: "احجز المواعيد بضغطو زرار فى أى وقت وفى أى مكان",
      title: "سهولة الحجز",
    ),
    OnModel(
      image: AppImages.on3,
      subtitle: "كن مطمئنا لأن خصوصيتك وأمانك هما أهم أولوياتنا",
      title: "أمن وسرى",
    ),
  ];

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          pageIndex != 2
              ? TextButton(
                  onPressed: () {
                    Navigation.pushAndRemoveUntil(
                      context,
                      Routes.welcomeScreen,
                    );
                  },
                  child: Text(
                    "تخطى",
                    style: TextStyles.body.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    pageIndex = index;
                    setState(() {});
                  },
                  itemBuilder: (context, i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(pages[i].image, height: 300, width: 300),
                        Gap(30),
                        Text(
                          pages[i].title,
                          style: TextStyles.subHeadline.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Gap(15),
                        Text(
                          pages[i].subtitle,
                          style: TextStyles.body,
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ],
                    );
                  },

                  itemCount: pages.length,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: pages.length,
                    axisDirection: Axis.horizontal,
                    effect: SlideEffect(
                      spacing: 8.0,
                      radius: 25.0,
                      dotWidth: 18.0,
                      dotHeight: 12.0,
                      paintStyle: PaintingStyle.fill,
                      strokeWidth: 1,
                      dotColor: AppColors.greyColor,
                      activeDotColor: AppColors.primaryColor,
                    ),
                  ),

                  pageIndex == 2
                      ? MainButton(
                          width: 50,
                          height: 50,

                          onPressed: () {
                            Navigation.pushAndRemoveUntil(
                              context,
                              Routes.welcomeScreen,
                            );
                          },
                          text: "هيا بنا",
                          bgColor: AppColors.primaryColor,
                          textColor: AppColors.backgroundColor,
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
