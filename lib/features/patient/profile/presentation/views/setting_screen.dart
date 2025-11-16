import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/payment/paymob/paymob.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/features/patient/profile/presentation/cubit/profile_cubit.dart';

import '../widgets/setting_list_tile.dart';

class SettingScreen extends StatelessWidget {
  final ProfileCubit cubit;
  const SettingScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("الاعدادات")),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              SettingListTile(
                onTap: () {
                  Navigation.push(context, Routes.accountSettingScreen, cubit);
                },
                leadingIcon: CupertinoIcons.person_fill,
                title: "إعدادات الحساب",
              ),
              SettingListTile(
                onTap: () async {
                  await Paymob.payWithPaymob("pk", "fd");
                },
                leadingIcon: Icons.security,
                title: "كلمة السر",
              ),
              SettingListTile(
                onTap: () {},
                leadingIcon: Icons.notifications_active,
                title: "إعدادات المنشور",
              ),
              SettingListTile(
                onTap: () {},
                leadingIcon: Icons.info_rounded,
                title: "الخصوصية",
              ),
              SettingListTile(
                onTap: () {},
                leadingIcon: Icons.question_mark,
                title: "المساعدة والدعم",
              ),
              SettingListTile(
                onTap: () {},
                leadingIcon: Icons.person_add_alt_1,
                title: "دعوة صديق",
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MainButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigation.pushAndRemoveUntil(
                      context,
                      Routes.welcomeScreen,
                    );
                  },
                  text: "تسجيل الخروج",
                  bgColor: AppColors.redAccent,
                  textColor: AppColors.backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
