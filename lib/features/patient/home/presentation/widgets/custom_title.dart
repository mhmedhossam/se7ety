import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  const CustomTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 16.0,
        top: 15,
        bottom: 15,
      ),
      child: Text(
        title,
        style: TextStyles.body.copyWith(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
