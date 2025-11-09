import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/features/patient/home/data/models/color_model.dart';

List<ColorModel> colors = [
  ColorModel(AppColors.primaryColor, const Color.fromARGB(255, 121, 205, 224)),
  ColorModel(
    AppColors.secondaryColor,
    const Color.fromARGB(255, 179, 237, 223),
  ),
  ColorModel(AppColors.lightBlue, const Color.fromARGB(255, 143, 214, 247)),
  ColorModel(AppColors.lightGreen, const Color.fromARGB(255, 204, 241, 163)),
  ColorModel(AppColors.greyColor, const Color.fromARGB(255, 220, 214, 214)),
];
