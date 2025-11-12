import 'package:flutter/cupertino.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/app_fonts.dart';
import 'package:se7ety/core/utils/textstyles.dart';

class CustomRichText extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  const CustomRichText({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyles.title.copyWith(
          fontFamily: AppFonts.cairoFamily,
          color: AppColors.darkColor,
          fontWeight: FontWeight.w400,
        ),
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.top,

            child: Icon(icon, color: AppColors.primaryColor, size: 24),
          ),
          TextSpan(text: title),
          TextSpan(
            text: subTitle,
            style: TextStyles.body.copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
