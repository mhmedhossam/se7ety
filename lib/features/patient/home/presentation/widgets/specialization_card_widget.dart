import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';

class SpecializationCardWidget extends StatelessWidget {
  final String specializationText;
  final Color primary;
  final Color light;
  final void Function() onTap;
  const SpecializationCardWidget({
    super.key,
    required this.specializationText,
    required this.primary,
    required this.light,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsetsDirectional.only(start: 10, end: 10),
        width: 150,
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: primary.withValues(alpha: 0.4),
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.directional(
              textDirection: TextDirection.rtl,
              start: -10,
              top: -12,
              child: CircleAvatar(
                radius: 55,
                backgroundColor: light.withValues(alpha: 0.5),
              ),
            ),
            Positioned.directional(
              bottom: 20,
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppImages.doctorCard, height: 100, width: 150),
                  Text(
                    specializationText,
                    style: TextStyles.body.copyWith(
                      color: AppColors.backgroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
