import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/features/patient/appointment/presentation/cubit/appoint_cubit.dart';
import 'package:se7ety/features/patient/appointment/presentation/view/appointment_screen.dart';
import 'package:se7ety/features/patient/home/presentation/view/home_screen.dart';
import 'package:se7ety/features/patient/profile/presentation/cubit/profile_cubit.dart';
import 'package:se7ety/features/patient/profile/presentation/views/profile_screen.dart';
import 'package:se7ety/features/patient/search/presentation/view/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  List<Widget> screens = [];
  @override
  void initState() {
    screens = [
      HomeScreen(),
      const SearchScreen(),
      BlocProvider(
        create: (context) => AppointCubit()..getMyAppointments(),
        child: AppointmentScreen(),
      ),
      BlocProvider(
        create: (context) => ProfileCubit()
          ..getProfileData()
          ..getoldAppointment(),
        child: ProfileScreen(),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screens[index],

        bottomNavigationBar: Container(
          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
          padding: EdgeInsets.fromLTRB(5, 12, 5, 20),
          width: double.infinity,
          // height: 100,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.darkColor.withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: 1,
                offset: Offset(0, -2),
              ),
            ],
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: GNav(
            onTabChange: (i) {
              index = i;
              setState(() {});
            },
            rippleColor: AppColors
                .backgroundColor, // tab button ripple color when pressed
            // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 20,
            selectedIndex: index,
            curve: Curves.easeOutExpo, // tab animation curves
            duration: Duration(milliseconds: 200), // tab animation duration
            gap: 20, // the tab button gap between icon and text
            color: AppColors.darkColor, // unselected icon color
            activeColor:
                AppColors.backgroundColor, // selected icon and text color
            iconSize: 26, // tab button icon size
            tabBackgroundColor:
                AppColors.primaryColor, // selected tab background color
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 16,
            ), // navigation bar padding
            tabs: [
              GButton(icon: Icons.home_filled, text: 'الرئيسية'),
              GButton(
                icon: LineIcons.search,
                text: 'البحث',
                // onPressed: () async {
                //   await FirebaseAuth.instance.signOut();
                // },
              ),
              GButton(icon: LineIcons.database, text: 'المواعيد'),
              GButton(icon: CupertinoIcons.person_fill, text: 'الحساب'),
            ],
          ),
        ),
      ),
    );
  }
}
