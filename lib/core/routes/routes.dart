import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/views/login_screen.dart';
import 'package:se7ety/features/auth/presentation/views/register_screen.dart';
import 'package:se7ety/features/intro/onboarding/onboarding_screen.dart';
import 'package:se7ety/features/intro/splash_screen/splash_screen.dart';
import 'package:se7ety/features/auth/data/models/enum.dart';
import 'package:se7ety/features/intro/welcome/welcome_screen.dart';

class Routes {
  static const String splashScreen = "/splash-screen";
  static const String onboardingScreen = "/onboarding-screen";
  static const String welcomeScreen = "/welcome-screen";
  static const String loginScreen = "/login-screen";
  static const String registerScreen = "/register-screen";

  static final appRoutes = GoRouter(
    initialLocation: splashScreen,
    routes: [
      GoRoute(path: splashScreen, builder: (context, state) => SplashScreen()),
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
