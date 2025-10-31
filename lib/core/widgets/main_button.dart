import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/textstyles.dart';

// ignore: must_be_immutable
class MainButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final double width;
  final double height;
  final Color bgColor;
  final Color textColor;
  final Color? borderColor;
  BorderRadiusGeometry? borderRadius;
  double? size;

  MainButton({
    super.key,
    required this.onPressed,
    this.borderRadius,
    this.size,
    required this.text,
    this.width = double.infinity,
    this.height = 55,
    required this.bgColor,
    this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
      ),
      child: Text(
        text,
        style: TextStyles.caption.copyWith(
          color: textColor,
          fontSize: size ?? 15,
        ),
      ),
    );
  }
}
