import 'package:se7ety/core/constants/app_images.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String subtitle;

  OnBoardingModel({
    required this.image,
    required this.subtitle,
    required this.title,
  });

  static List<OnBoardingModel> pages = [
    OnBoardingModel(
      image: AppImages.on1,
      subtitle:
          "اكتشف مجموعه واسعه من الأطباء الخبراء والمتخصصين فى مختلف المجالات ",
      title: "ابحث عن دكتور متخصص",
    ),
    OnBoardingModel(
      image: AppImages.on2,
      subtitle: "احجز المواعيد بضغطو زرار فى أى وقت وفى أى مكان",
      title: "سهولة الحجز",
    ),
    OnBoardingModel(
      image: AppImages.on3,
      subtitle: "كن مطمئنا لأن خصوصيتك وأمانك هما أهم أولوياتنا",
      title: "أمن وسرى",
    ),
  ];
}
