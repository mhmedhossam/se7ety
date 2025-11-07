import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/sharedpref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      var role = FirebaseAuth.instance.currentUser?.photoURL;
      Navigation.pushAndRemoveUntil(
        context,

        role != null
            ? role == "patient"
                  ? Routes.mainScreen
                  : Routes
                        .registerScreen // change to doctor screen
            : SharedPref.getOnBoardingShown
            ? Routes.welcomeScreen
            : Routes.onboardingScreen,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [Image.asset(AppImages.se7ety, height: 300)],
        ),
      ),
    );
  }
}
