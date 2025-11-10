import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/textstyles.dart';

class CustomAlignText extends StatelessWidget {
  final String text;
  final AlignmentGeometry alignment;
  const CustomAlignText({
    super.key,
    required this.text,
    this.alignment = Alignment.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Text(
        text,
        style: TextStyles.title.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }
}
