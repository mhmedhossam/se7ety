import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/textstyles.dart';

class CustomAlignText extends StatelessWidget {
  final String text;
  const CustomAlignText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Text(
        text,
        style: TextStyles.title.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }
}
