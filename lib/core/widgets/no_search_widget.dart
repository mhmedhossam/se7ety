import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/utils/textstyles.dart';

class NoSearchWidget extends StatelessWidget {
  final String text;
  const NoSearchWidget({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImages.noSearch, height: 200),

          Text(text, style: TextStyles.body),
        ],
      ),
    );
  }
}
