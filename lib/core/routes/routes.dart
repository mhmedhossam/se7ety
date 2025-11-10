import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/views/dr_complete_register.dart';
import 'package:se7ety/features/auth/presentation/views/login_screen.dart';
import 'package:se7ety/features/auth/presentation/views/register_screen.dart';
import 'package:se7ety/features/intro/onboarding/onboarding_screen.dart';
import 'package:se7ety/features/intro/splash_screen/splash_screen.dart';
import 'package:se7ety/features/auth/data/models/enum.dart';
import 'package:se7ety/features/intro/welcome/welcome_screen.dart';
import 'package:se7ety/features/patient/home/presentation/view/search_result_screen.dart';
import 'package:se7ety/features/patient/home/presentation/view/specialization_search_screen.dart';
import 'package:se7ety/features/patient/main/main_screen.dart';
import 'package:se7ety/features/patient/profile/presentation/cubit/profile_cubit.dart';
import 'package:se7ety/features/patient/profile/presentation/views/account_setting_screen.dart';
import 'package:se7ety/features/patient/profile/presentation/views/setting_screen.dart';

class Routes {
  static const String splashScreen = "/splash-screen";
  static const String settingScreen = "/setting-screen";
  static const String accountSettingScreen = "/account_setting-screen";
  static const String onboardingScreen = "/onboarding-screen";
  static const String welcomeScreen = "/welcome-screen";
  static const String loginScreen = "/login-screen";
  static const String registerScreen = "/register-screen";
  static const String mainScreen = "/main-screen";
  static const String drCompleteRegisterScreen = "/drCompleteRegister-screen";
  static const String searchResultScreen = "/SearchResult_screen";
  static const String specializationSearchScreen =
      "/specialization_search_screen";

  static final appRoutes = GoRouter(
    initialLocation: splashScreen,
    routes: [
      GoRoute(path: splashScreen, builder: (context, state) => SplashScreen()),
      GoRoute(
        path: settingScreen,
        builder: (context, state) {
          return SettingScreen(cubit: state.extra as ProfileCubit);
        },
      ),
      GoRoute(
        path: searchResultScreen,
        builder: (context, state) =>
            SearchResultScreen(value: state.extra as String),
      ),
      GoRoute(
        path: specializationSearchScreen,
        builder: (context, state) =>
            SpecializationSearchScreen(specialization: state.extra as String),
      ),
      GoRoute(path: mainScreen, builder: (context, state) => MainScreen()),
      GoRoute(
        path: accountSettingScreen,
        builder: (context, state) => BlocProvider.value(
          value: state.extra as ProfileCubit,
          child: AccountSettingScreen(),
        ),
      ),
      GoRoute(
        path: drCompleteRegisterScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => AuthCubit(),
            child: DrCompleteRegisterScreen(),
          );
        },
      ),
      GoRoute(
        path: loginScreen,
        builder: (context, state) {
          var loginPerson = state.extra as UserTypeEnum;

          return BlocProvider(
            create: (context) => AuthCubit(),
            child: LoginScreen(person: loginPerson),
          );
        },
      ),
      GoRoute(
        path: registerScreen,
        builder: (context, state) {
          var registerPerson = state.extra as UserTypeEnum;

          return BlocProvider(
            create: (context) => AuthCubit(),
            child: RegisterScreen(person: registerPerson),
          );
        },
      ),
      GoRoute(
        path: welcomeScreen,
        builder: (context, state) => WelcomeScreen(),
      ),
      GoRoute(
        path: onboardingScreen,
        builder: (context, state) => OnboardingScreen(),
      ),
    ],
  );
}
