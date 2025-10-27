import 'package:go_router/go_router.dart';
import 'package:se7ety/features/intro/onboarding/onboarding.dart';
import 'package:se7ety/features/intro/splash_screen/splash_screen.dart';
import 'package:se7ety/features/intro/welcome/welcome.dart';

class Routes {
  static const String splashScreen = "/splash-screen";
  static const String onboardingScreen = "/onboarding-screen";
  static const String welcomeScreen = "/welcome-screen";

  static final appRoutes = GoRouter(
    initialLocation: splashScreen,
    routes: [
      GoRoute(path: splashScreen, builder: (context, state) => SplashScreen()),
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
