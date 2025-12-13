import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/presentation/cubit/theme_cubit/theme_states.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitialState());

  bool isDark = false;

  void changeTheme() {
    isDark = !isDark;
    emit(ThemeChangeState());
  }
}
