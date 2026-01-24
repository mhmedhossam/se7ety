import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/presentation/cubit/theme_cubit/theme_states.dart';
import 'package:se7ety/core/services/local/sharedpref.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitialState());

  bool isDark = SharedPref.getData(SharedPref.kIsDark);
  void changeTheme() {
    isDark = !isDark;
    SharedPref.setTheme(isDark);
    emit(ThemeChangeState());
  }
}
