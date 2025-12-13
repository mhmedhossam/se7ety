import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/presentation/cubit/theme_cubit/theme_cubit.dart';

extension ThemeEx on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension LocalizedEx on BuildContext {
  bool get isArabic => locale.languageCode == 'ar';
}

extension ThemeCubitEx on BuildContext {
  ThemeCubit get themeCubit => read<ThemeCubit>();
}
