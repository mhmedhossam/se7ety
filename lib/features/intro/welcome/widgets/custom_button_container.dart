import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';

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
